<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">Post a New Message</h1>
        </div>
      </div>
    </div>

    <div class="flex mt-4 bg-gray-900">
      <message-form
        :form="form"
        class="bg-gray-900 w-full"
        @submit="submit"
      >
        <div class="px-2 py-3 border-t border-gray-800 flex justify-end items-center">
          <button
            class="btn-indigo-outline mr-2"
            type="submit"
          >
            Save as draft
          </button>
          <loading-button
            :loading="sending"
            class="btn-green"
            type="submit"
          >
            Post Message
          </loading-button>
        </div>
      </message-form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import LoadingButton from '@/Components/LoadingButton'
import MessageForm from './MessageForm'
import currentProject from '@/utils/currentProject'

export default {
  layout: Layout,
  components: {
    LoadingButton,
    MessageForm,
  },
  mixins: [currentProject],
  remember: 'form',
  data() {
    return {
      sending: false,
      form: {
        subject: null,
        content: null,
      },
    }
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.post(this.$routes.project_messages(this.project.id), this.form).then(() => {
        this.sending = false
        if (Object.keys(this.$page.errors).length === 0) {
          this.form = {}
          this.$emit('success')
        }
      })
    },
  },
  computed: {
  }
}
</script>
