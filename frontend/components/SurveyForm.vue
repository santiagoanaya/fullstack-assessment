<template>
  <v-card>
    <div class="py-10 accent-bg px-6 d-flex flex-column align-center">
      <h2> Creación de encuesta </h2>
    </div>
    <validation-observer
      ref="observer"
      v-slot="{ invalid }"
    >
      <form @submit.prevent="submit">
        <v-container fluid>
          <validation-provider
            v-slot="{ errors }"
            name="Titulo"
            rules="required|max:20"
          >
            <v-row>
              <v-col cols="3">
                <v-subheader>Titulo</v-subheader>
              </v-col>
              <v-col cols="8">
                <v-text-field
                  v-model="creationSurvey.title"
                  :counter="20"
                  :error-messages="errors"
                  label="Titulo"
                  outlined
                  required
                />
                <span>{{ errors[0] }}</span>
              </v-col>
            </v-row>
          </validation-provider>

          <validation-provider
            v-slot="{ errors }"
            name="Descripción"
            rules="required|max:40"
          >
            <v-row>
              <v-col cols="3">
                <v-subheader>Descripción</v-subheader>
              </v-col>
              <v-col cols="8">
                <v-text-field
                  v-model="creationSurvey.description"
                  :counter="40"
                  :error-messages="errors"
                  label="Descripción"
                  outlined
                  required
                />
              </v-col>
            </v-row>
          </validation-provider>

          <v-row>
            <v-col cols="12">
              <v-container class="border my-4" v-for="(question, index) in creationSurvey.questions" :key="index">
                <v-row>
                  <v-col cols="3">
                    <v-subheader>Tipo de Pregunta</v-subheader>
                  </v-col>
                  <v-col cols="8">
                    <v-select
                      v-model="question.type"
                      label="Elige un tipo"
                      :items="typeOptions"
                      item-text="text"
                      item-value="value"
                      :error-messages="errors"
                      data-vv-name="select"
                      outlined
                      required
                    />
                  </v-col>
                </v-row>
                <validation-provider
                  v-slot="{ errors }"
                  name="Pregunta"
                  rules="required|max:40"
                >
                <v-row>
                    <v-col cols="3">
                      <v-subheader>Pregunta</v-subheader>
                    </v-col>
                    <v-col cols="8">
                    <v-text-field
                      v-model="question.text"
                      :counter="40"
                      :error-messages="errors"
                      label="Pregunta"
                      outlined
                      required
                    />
                  </v-col>
                </v-row>
                </validation-provider>
                <div v-if="question.type !== 'FC'">
                  <v-row v-for="(option, index) in question.options" :key="index">
                    <v-col cols="3">
                      <v-subheader>Opción {{ getOptionNumber(index)}}</v-subheader>
                    </v-col>
                    <v-col cols="8">
                      <v-text-field
                        v-model="option.text"
                        :label="`Opción ${getOptionNumber(index)}`"
                        outlined
                        required
                      >
                        <template v-slot:append-outer>
                          <v-icon color="red" @click="deleteOption(question, index)">
                            mdi-minus-circle-outline
                          </v-icon>
                        </template>
                      </v-text-field>
                    </v-col>
                  </v-row>
                  <v-chip
                    class="ma-2"
                    @click="addOption(question)"
                  >
                    <v-avatar left>
                      <v-icon color="purple">mdi-plus-circle</v-icon>
                    </v-avatar>
                    Agregar opción
                  </v-chip>
                </div>
              </v-container>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="4">
              <v-chip
                  class="ma-2"
                  @click="addQuestion"
              >
                <v-avatar left>
                  <v-icon color="purple">mdi-plus-circle</v-icon>
                </v-avatar>
                Agregar pregunta
              </v-chip>
            </v-col>
          </v-row>

          <v-row>
            <v-col cols="4">
              <v-btn
                type="submit"
              >
                Crear Encuesta
              </v-btn>
            </v-col>
            <v-col cols="4">
              <v-btn @click="clear">
                Limpiar datos
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </form>
    </validation-observer>
  </v-card>
</template>

<script>
  import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
  import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'

  setInteractionMode('eager')

  extend('digits', {
    ...digits,
    message: '{_field_} needs to be {length} digits. ({_value_})',
  })

  extend('required', {
    ...required,
    message: '{_field_} can not be empty',
  })

  extend('max', {
    ...max,
    message: '{_field_} may not be greater than {length} characters',
  })

  extend('regex', {
    ...regex,
    message: '{_field_} {_value_} does not match {regex}',
  })

  extend('email', {
    ...email,
    message: 'Email must be valid',
  })

  export default {
    components: {
      ValidationProvider,
      ValidationObserver
    },
    props: {
      creationSurvey: {
        type: Object,
        required: true
      }
    },
    data:() => ({
      typeOptions: [
        {
        text: 'Single Choice',
        value: 'SC'
        },
        {
        text: 'Multiple Choice',
        value: 'MC'
        },
        {
        text: 'Free Choice',
        value: 'FC'
        }
      ],
      newQuestion: {
        type: '',
        text: '',
        options: [{
          text: ''
        }]
      },
      newOption: {
        text: ''
      }
    }),
    methods: {
      addOption(question) {
        question = question.options.push(this.newOption)
      },
      deleteOption(question, index) {
        question = question.options.splice(index, 1)
      },
      getOptionNumber(index) {
        return index + 1
      },
      // getter in vuex
      addQuestion() {
        this.creationSurvey.questions.push(this.newQuestion)
      },
      submit () {
        this.$refs.observer.validate()
      },
      clear () {
        this.name = ''
        this.phoneNumber = ''
        this.email = ''
        this.select = null
        this.checkbox = null
        this.$refs.observer.reset()
      },
    }
  }
</script>

<style>
  .border {
    display: inline-block;
    border: 2px solid white;
  }
</style>