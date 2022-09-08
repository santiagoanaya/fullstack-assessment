<template>
  <v-card>
    <div class="py-10 accent-bg px-6 d-flex flex-column align-center">
      <h2>Creación de encuesta</h2>
    </div>
    <form @submit.prevent="submit">
      <v-container fluid>
        <v-row>
          <v-col cols="3">
            <v-subheader>Título</v-subheader>
          </v-col>
          <v-col cols="8">
            <v-text-field
              v-model="creationSurvey.title"
              :counter="40"
              label="Ingrese un Título"
              outlined
              required
            />
          </v-col>
        </v-row>

        <v-row>
          <v-col cols="3">
            <v-subheader>Descripción</v-subheader>
          </v-col>
          <v-col cols="8">
            <v-text-field
              v-model="creationSurvey.description"
              :counter="60"
              label="Ingrese una Descripción"
              outlined
              required
            />
          </v-col>
        </v-row>

        <v-row>
          <v-col cols="12">
            <v-row
              v-for="(question, index) in creationSurvey.questions"
              :key="index"
            >
              <v-col cols="11">
                <v-container class="border my-4">
                  <v-row>
                    <v-col cols="3">
                      <v-subheader>Tipo de Pregunta</v-subheader>
                    </v-col>
                    <v-col cols="8">
                      <v-select
                        v-model="question.question_type"
                        label="Elija un Tipo"
                        :items="answersTypes"
                        item-text="text"
                        item-value="value"
                        data-vv-name="select"
                        outlined
                        required
                      />
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col cols="3">
                      <v-subheader>Pregunta</v-subheader>
                    </v-col>
                    <v-col cols="8">
                      <v-text-field
                        v-model="question.title"
                        :counter="40"
                        label="Pregunta"
                        outlined
                        required
                      />
                    </v-col>
                  </v-row>

                  <div v-if="question.question_type !== 'free_choice'">
                    <v-row
                      v-for="(answer, index) in question.answers"
                      :key="index"
                    >
                      <v-col cols="3">
                        <v-subheader
                          >Opción {{ getAnswerNumber(index) }}</v-subheader
                        >
                      </v-col>
                      <v-col cols="9">
                        <v-text-field
                          v-model="answer.title"
                          :label="`Opción ${getAnswerNumber(index)}`"
                          :rules="[
                            (text) => !!text || 'This field is required',
                          ]"
                          outlined
                          required
                        >
                          <template v-slot:append-outer>
                            <v-icon
                              class="ml-2"
                              color="red"
                              @click="deleteAnswer(question, index)"
                              :disabled="question.answers.length < 3"
                            >
                              mdi-minus-circle-outline
                            </v-icon>
                          </template>
                        </v-text-field>
                      </v-col>
                    </v-row>
                    <v-chip class="ma-2" @click="addAnswer(question)">
                      <v-avatar left>
                        <v-icon color="purple">mdi-plus-circle</v-icon>
                      </v-avatar>
                      Agregar Opción
                    </v-chip>
                  </div>
                </v-container>
              </v-col>
              <v-col cols="1" class="align-self-center">
                <v-icon
                  color="red"
                  @click="deleteQuestion(index)"
                  :disabled="creationSurvey.questions.length < 2"
                >
                  mdi-delete
                </v-icon>
              </v-col>
            </v-row>
          </v-col>
        </v-row>

        <v-row>
          <v-col cols="6">
            <v-chip class="ma-2" @click="addQuestion">
              <v-avatar left>
                <v-icon color="purple">mdi-plus-circle</v-icon>
              </v-avatar>
              Agregar Pregunta
            </v-chip>
          </v-col>
        </v-row>

        <v-row>
          <v-col cols="4">
            <v-btn @click="$emit('submitSurvey')"> Crear Encuesta </v-btn>
          </v-col>
          <!-- <v-col cols="4">
              <v-btn @click="clear">
                Limpiar datos
              </v-btn>
            </v-col> -->
        </v-row>
      </v-container>
    </form>
  </v-card>
</template>

<script>
const getEmptyAnswer = () => ({
  title: "",
})
const getEmptyQuestion = () => ({
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
})

export default {
  props: {
    creationSurvey: {
      type: Object,
      required: true,
    },
  },
  data: () => ({
    answersTypes: [
      {
        text: "Respuesta Única",
        value: "single_choice",
      },
      {
        text: "Respuesta Múltiple",
        value: "multiple_choice",
      },
      {
        text: "Respuesta Libre",
        value: "free_choice",
      },
    ],
  }),
  methods: {
    addQuestion() {
      this.creationSurvey.questions.push(getEmptyQuestion())
    },
    addAnswer(question) {
      question = question.answers.push(getEmptyAnswer())
    },
    // getter in vuex
    deleteAnswer(question, index) {
      question = question.answers.splice(index, 1)
    },
    getAnswerNumber(index) {
      return index + 1
    },

    deleteQuestion(index) {
      if (this.creationSurvey.questions.length < 2) {
        this.creationSurvey.questions.splice(index, 1)
      }
    },
    submit() {
      this.$refs.observer.validate()
    },
    clear() {
      this.name = ""
      this.phoneNumber = ""
      this.email = ""
      this.select = null
      this.checkbox = null
      this.$refs.observer.reset()
    },
  },
}
</script>

<style>
.border {
  display: inline-block;
  border: 2px solid white;
}
</style>
