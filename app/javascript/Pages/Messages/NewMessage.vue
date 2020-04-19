<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">
            Post a New Message
          </h1>
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

export default {
  layout: Layout,
  components: {
    LoadingButton,
    MessageForm,
  },
  remember: 'form',
  props: {
    message: {
      type: Object,
      required: true,
    },
    message_board: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      sending: false,
      form: {
        subject: null,
        content: null,
      },
    }
  },
  computed: {
    currentBucket() {
      return this.$page.current_bucket
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.post(this.$routes.bucket_message_board_messages(this.currentBucket), this.form).then(() => {
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
