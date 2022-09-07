<template>
  <div>
    <v-checkbox
      v-model="options"
      v-for="(option, index) in options"
      :label="option.text"
      :key="index"
    />
  </div>
</template>

<script>
  export default {
    props: {
      options: {
        type: Array
      }
    }
  }
</script>
