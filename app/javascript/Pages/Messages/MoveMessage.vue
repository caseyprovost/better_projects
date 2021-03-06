<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">
            Move this message
          </h1>
        </div>
      </div>
    </div>

    <div class="flex mt-4 bg-gray-900 md:justify-between md:flex-wrap">
      <div class="hidden md:block md:w-1/3">
        <div
          class="bg-purple-900 shadow px-4 py-2 text-xs m-2"
          style="min-height: 8.5rem"
        >
          <div>
            {{ message.subject }}
          </div>
          <div
            class="text-purple-100"
            v-html="message.content.body"
          />
        </div>
      </div>
      <div class="md:w-2/3 w-full">
        <move-message-form
          :form="form"
          class="bg-gray-900"
          :projects="projects"
          @submit="submit"
        />
        <div class="px-4 md:py-1 flex justify-end items-center flex-1 pt-2 pb-4">
          <inertia-link
            :href="messagePath"
            class="btn-blue-outline mr-1"
          >
            Nevermind
          </inertia-link>
          <loading-button
            :loading="sending"
            class="btn-green"
            type="submit"
            @click="submit"
          >
            Move to this project
          </loading-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import LoadingButton from '@/Components/LoadingButton'
import MoveMessageForm from './MoveMessageForm'
import currentProject from '@/utils/currentProject'

export default {
  layout: Layout,
  components: {
    LoadingButton,
    MoveMessageForm,
  },
  mixins: [currentProject],
  remember: 'form',
  props: {
    move: {
      type: Object,
      required: true,
    },
    message: {
      type: Object,
      required: true,
    },
    projects: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      sending: false,
      form: {
        project_id: this.move.project_id,
      },
    }
  },
  computed: {
    messagePath() {
      return this.$routes.project_message(this.project, this.message)
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.post(this.$routes.project_message_moves(this.project.id, this.message.id), this.form).then(() => {
        this.sending = false
        if (Object.keys(this.$page.errors).length === 0) {
          this.form = {}
          this.$emit('success')
        }
      })
    },
  },
}
</script>
