<template>
  <v-radio-group v-model="options">
    <v-radio
      v-for="(option, index) in options"
      :key="index"
      :label="option.text"
      :value="index"
    />
  </v-radio-group>
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
