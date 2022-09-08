<template>
  <v-row justify="center" class="mt-10">
    <v-alert v-if="showAlert" border="bottom" color="red">
      {{ alertText }}
    </v-alert>
    <v-col cols="4" v-if="mode === 'create'">
      <survey-form
        :creationSurvey="creationSurvey"
        v-model="creationSurvey"
        @submitSurvey="submitSurvey"
      />
    </v-col>
    <v-col :cols="mode === 'create' ? 4 : 8">
      <survey-welcome v-if="mode === 'welcome'" />
      <survey-detail
        v-else
        :survey="mode === 'create' ? creationSurvey : selectedSurvey"
      />
    </v-col>
    <v-col cols="4">
      <survey-list
        @select="selectSurvey"
        @createSurvey="createSurvey"
        :surveys="surveys"
        :isLoading="isLoading"
      />
    </v-col>
  </v-row>
</template>

<script>
const getEmptySurvey = () => ({
  title: "",
  description: "",
  questions: [
    {
      question_type: "",
      title: "",
      answers: [
        {
          title: "",
        },
        {
          title: "",
        },
      ],
    },
  ],
})
export default {
  name: "IndexPage",
  data: () => ({
    mode: "welcome",
    surveys: [],
    creationSurvey: getEmptySurvey(),
    selectedSurvey: {},
    isLoading: false,
    showAlert: false,
    alertText: "",
  }),
  created() {
    this.isLoading = true
    this.selectedSurvey = getEmptySurvey()
    this.$axios
      .$get("/api/surveys")
      .then((responseSurveys) => {
        this.surveys = responseSurveys
        this.isLoading = false
      })
      .catch((e) => {
        this.showAlert = true
        this.alertText = e
      })
  },
  methods: {
    selectSurvey(surveyToSelect) {
      this.selectedSurvey = surveyToSelect
      this.mode = "select"
    },
    createSurvey() {
      this.creationSurvey = getEmptySurvey()
      this.mode = "create"
    },
    submitSurvey() {
      const submitionSurvey = {
        survey: {
          title: this.creationSurvey.title,
          description: this.creationSurvey.title,
          questions_attributes: this.creationSurvey.questions.map((q) =>
            Object.assign(
              {},
              {
                title: q.title,
                question_type: q.question_type,
                answers_attributes: q.answers,
              }
            )
          ),
        },
      }
      this.$axios
        .$post("/api/surveys", submitionSurvey)
        .then(() => {
          this.surveys.push(this.creationSurvey)
          this.selectedSurvey = this.creationSurvey
          this.mode = "select"
        })
        .catch((e) => {
          this.showAlert = true
          this.alertText = e
        })
    },
  },
}
</script>
