<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-between items-center">
          <h1 class="text-indigo-400 text-3xl flex-1">
            Message Board
          </h1>
          <inertia-link
            :href="this.$routes.new_bucket_message_board_message(currentBucket)"
            class="btn btn-indigo"
          >
            New Message
          </inertia-link>
        </div>
      </div>
    </div>
    <div class="flex">
      <div class="w-full flex flex-wrap mt-4">
        <inertia-link
          v-for="message in messages"
          :key="message.id"
          :href="messagePath(message)"
          class="bg-gray-900 rounded-lg shadow-xl p-4 w-full border border-transparent items-center mt-2 block hover:cursor-pointer hover:border-pink-600"
          data-component="MessageBox"
        >
          <h3 class="text-gray-500 flex-1 leading-normal font-semibold">
            <span>{{ message.subject }}</span>
          </h3>
          <div class="message-meta text-gray-500 leading-normal text-purple-700">
            <span>{{ message.creator.name }} - </span>
            <span>{{ messageCreatedAt(message) }}</span>
          </div>
          <p class="flex-1 text-gray-500 py-2">
            {{ message.content_preview }}
          </p>
        </inertia-link>
      </div>
    </div>
  </div>
</template>

<script>
  import Layout from '@/Layouts/Main'

  export default {
    layout: Layout,
    components: {
    },
    props: {
      messages: {
        type: Array,
        required: true,
      },
    },
    computed: {
      project() {
        return this.$page.current_bucket.bucketable
      },
      currentBucket() {
        return this.$page.current_bucket
      },
    },
    methods: {
      messagePath(message) {
        return this.$routes.bucket_message(this.currentBucket, message)
      },
      messageCreatedAt(message) {
        let dateString = message.created_at.toString()
        const date = new Date(dateString)
        const month = date.toLocaleString('default', { month: 'short' })
        return `${month} ${date.getDay()}, ${date.getFullYear()}`
      },
    },
  }
</script>
