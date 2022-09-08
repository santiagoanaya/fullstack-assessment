<template>
  <div>
    <v-checkbox
      v-for="(answer, index) in answers"
      :label="answer.title"
      :value="index"
      :key="index"
    />
  </div>
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
