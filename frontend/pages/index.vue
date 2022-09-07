<template>
  <v-row justify="center" class="mt-10">
    <v-col cols="4" v-if="mode === 'create'">
      <survey-form :creationSurvey="creationSurvey" v-model="creationSurvey" @submit="submitSurvey"/>
    </v-col>
    <v-col :cols="mode === 'create' ? 4 : 8">
      <survey-welcome v-if="mode === 'welcome'"/>
      <survey-detail v-else :survey="mode === 'create' ? creationSurvey : selectedSurvey"/>
    </v-col>
    <v-col cols="4">
      <survey-list @select="selectSurvey" @createSurvey="createSurvey" :surveys="surveys"/>
    </v-col>
  </v-row>
</template>

<script>
  // import Vue from 'vue'
  export default {
    name: 'IndexPage',
    data:() => ({
      mode: '',
      newSurvey: {
        title: '',
        description: '',
        questions: [
          {
            type: '',
            text: '',
            options: [{
              text: ''
            }]
          }
        ]
      },
      creationSurvey: {},
      selectedSurvey: {},
      surveys: [
        {
          title: 'Encuesta 1',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          questions: [
            {
              type: 'SC',
              text: 'Pregunta 1',
              options: [{
                text: 'Opcion de la pregunta 1'
              },
              {
                text: 'Opcion de la pregunta 1'
              }]
            },
            {
              type: 'MC',
              text: 'Pregunta 2',
              options: [
                {
                text: 'Opcion de la pregunta 2'
                },
                {
                text: 'Opcion de la pregunta 2'
                }
              ]
            }
          ]
        },
        {
          title: 'Encuesta 2',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          questions: [
            {
              type: 'FC',
              text: 'Pregunta 1'
            }
          ]
        },
        {
          title: 'Encuesta 3',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          questions: [
            {
              type: 'FC',
              text: 'Pregunta 1',
            }
          ]
        },
        {
          title: 'Encuesta 4',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          questions: [
            {
              type: 'FC',
              text: 'Pregunta 1',
            },
            {
              type: 'SC',
              text: 'Pregunta 2',
              options: [{
                text: 'Opcion de la pregunta 2'
              },
              {
                text: 'Opcion de la pregunta 2'
              }]
            },
            {
              type: 'MC',
              text: 'Pregunta 3',
              options: [
                {
                text: 'Opcion de la pregunta 3'
                },
                {
                text: 'Opcion de la pregunta 3'
                }
              ]
            }
          ]
        }
      ]
    }),
    created() {
      this.mode = 'welcome'
      // this.creationSurvey = Object.assign(this.creationSurvey, this.newSurvey)
      this.creationSurvey = this.newSurvey
      
      this.selectedSurvey = this.newSurvey
    },
    methods: {
      selectSurvey(surveyToSelect) {
        this.selectedSurvey = surveyToSelect
        this.mode = 'select'
      },
      createSurvey() {
        this.creationSurvey = {}
        this.creationSurvey = this.newSurvey
        // Vue.set(this.creationSurvey, this.newSurvey)
        this.mode = 'create'
      },
      submitSurvey() {
        this.surveys.push(this.creationSurvey)
        this.selectedSurvey = this.creationSurvey
        this.mode = 'select'
      }
    }
  }
</script>
