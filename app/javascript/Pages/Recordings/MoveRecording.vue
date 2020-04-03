<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">
            Move this {{ topic }}
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
            {{ recording.subject }}
          </div>
          <div
            class="text-purple-100"
            v-html="recording.content.body"
          />
        </div>
      </div>
      <div class="md:w-2/3 w-full">
        <copy-recording-form
          :form="form"
          class="bg-gray-900"
          :buckets="buckets"
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
            Move to this location
          </loading-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import LoadingButton from '@/Components/LoadingButton'
import CopyRecordingForm from './CopyRecordingForm'

export default {
  layout: Layout,
  components: {
    LoadingButton,
    CopyRecordingForm,
  },
  remember: 'form',
  props: {
    move: {
      type: Object,
      required: true,
    },
    recording: {
      type: Object,
      required: true,
    },
    buckets: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      sending: false,
      form: {
        destination_bucket_id: this.move.destination_bucket_id,
      },
    }
  },
  computed: {
    messagePath() {
      return this.$routes.bucket_message(this.currentBucket, this.recording.recordable)
    },
    topic() {
      let baseName = this.recording.recordable_type.toLowerCase()
      return baseName.replace('_', ' ')
    },
    currentBucket() {
      return this.$page.current_bucket
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia.post(this.$routes.bucket_recording_moves(this.currentBucket, this.recording), this.form).then(() => {
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
