<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">
            Edit {{ message.subject }}
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
          <inertia-link
            :href="messagePath"
            class="btn-blue-outline mr-1"
          >
            Discard changes
          </inertia-link>
          <loading-button
            :loading="sending"
            class="btn-green"
            type="submit"
          >
            Save Changes
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
  },
  data() {
    return {
      sending: false,
      form: {
        subject: this.message.subject,
        content: this.message.content.body,
      },
    }
  },
  computed: {
    messagePath() {
      return this.$routes.bucket_message(this.currentBucket, this.message)
    },
    currentProject() {
      return this.$page.current_bucket.bucketable
    },
    currentBucket() {
      return this.$page.current_bucket
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.patch(this.$routes.bucket_message(this.currentBucket, this.message), this.form).then(() => {
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
