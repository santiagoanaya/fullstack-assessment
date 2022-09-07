<template>
  <v-card>
    <div class="py-10 accent-bg px-6 d-flex flex-column align-center">
      <h2 class="pb-6">
        {{ !survey.title ? 'Ingrese un Titulo' : survey.title }}
      </h2>
      <v-card-subtitle>
        {{ !survey.description ? 'Ingrese una Descripción' :survey.description }}
      </v-card-subtitle>
    </div>
    <v-card-text>
      <v-container fluid>
        <div v-if="!survey.questions[0].text">
          <p>Ingrese preguntas</p>
        </div>
        <div v-else v-for="(question, index) in survey.questions" :key="index">
          {{ question.text }}
          <question-single-choice v-if="question.type === 'SC'" v-model="question.options" :options="question.options"/>
          <question-multiple-choice v-else-if="question.type === 'MC'" v-model="question.options" :options="question.options"/>
          <question-free-choice v-else-if="question.type === 'FC'"/>
        </div>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script>
  export default {
    props: {
      survey: {
        type: Object,
        required: true
      }
    }
  }
  </script>
<style>
  .accent-bg {
    background-color: #6a1b9a;
    color: white;
  }
</style>