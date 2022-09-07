<template>
    <div>
      <v-btn color="primary" block @click="$emit('createSurvey')">
        Crear Encuesta
        <v-icon>
          mdi-plus
        </v-icon>
      </v-btn>
        <v-card v-for="(survey, index) in surveys" :key="index" @click="$emit('select', survey)" elevation="4" class="my-4">
          <v-card-title>
            {{ survey.title }}
          </v-card-title>
          <v-card-subtitle class="max-lines-1">
            {{ survey.description }}
          </v-card-subtitle>
          <v-card-text class="mt-3">
            <v-avatar color="primary" size="36">
              {{ survey.questions.length }}
            </v-avatar>
            {{ survey.questions.length > 1 ? 'preguntas' : 'pregunta' }}
          </v-card-text>
        </v-card>
    </div>
</template>

<script>
export default {
  props: {
    surveys: {
      type: Array,
      required: true
    }
  },
  data:() => ({
  })
}
</script>