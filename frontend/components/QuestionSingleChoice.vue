<template>
  <v-radio-group>
    <v-radio
      v-for="(answer, index) in answers"
      :key="index"
      :label="answer.title"
      :value="index"
    />
  </v-radio-group>
</template>

<script>
export default {
  props: {
    answers: {
      type: Array,
    },
  },
}
</script>
