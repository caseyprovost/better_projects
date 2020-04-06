<template>
  <div
    v-if="showCrumbs"
    class="bg-gray-700 py-2 px-3"
  >
     <div class="breadcrumb relative inline-block pr-2">
      <inertia-link
        :href="this.$routes.projects()"
        class="text-gray-100 underline hover:text-green-400 font-semibold"
      >
        Projects
      </inertia-link>
    </div>
    <div class="breadcrumb relative inline-block px-2">
      <inertia-link
        :href="this.$routes.project(bucket.bucketable.id)"
        class="text-gray-100 underline hover:text-green-400 font-semibold"
      >
        {{ bucket.bucketable.name }}
      </inertia-link>
    </div>
    <div
      v-if="showMessageBoardBreadcrumb"
      class="breadcrumb relative inline-block pr-2"
    >
      <inertia-link
        :href="this.$routes.bucket_message_board(bucket)"
        class="text-gray-100 underline hover:text-green-400 ml-2"
      >
        Message Board
      </inertia-link>
    </div>
    <div
      v-if="showMessageBreadcrumb && recording"
      class="breadcrumb relative inline-block pr-2"
    >
      <inertia-link
        :href="this.$routes.bucket_message(bucket, recording.recordable_id)"
        class="text-gray-100 underline hover:text-green-400 ml-2"
      >
        {{ recording.title }}
      </inertia-link>
    </div>
     <div
      v-if="showTodoSetBreadcrumb"
      class="breadcrumb relative inline-block pr-2"
    >
      <inertia-link
        :href="this.$routes.bucket_todo_set(bucket, this.$page.todo_set)"
        class="text-gray-100 underline hover:text-green-400 ml-2"
      >
        To-dos
      </inertia-link>
    </div>
  </div>
</template>

<script>

export default {
  components: {
  },
  props: {
    message: {
      type: Object,
      required: false,
      default: null,
    },
    project: {
      type: Object,
      required: false,
      default: null,
    },
    bucket: {
      type: Object,
      required: false,
      default: null,
    },
    recording: {
      type: Object,
      required: false,
      default: null,
    },
  },
  data() {
    return {
    }
  },
  computed: {
    showCrumbs() {
      return (this.bucket && this.project) || (this.bucket && this.$page.todo_set)
    },
    showMessageBoardBreadcrumb() {
      let routes = [
        this.$routes.new_bucket_message_board_message(this.bucket),
      ]

      if (this.message && this.message.id) {
        routes.push(this.$routes.edit_bucket_message(this.bucket, this.message))
        routes.push(this.$routes.bucket_message(this.bucket, this.message))
      }

      let result = routes.indexOf(location.pathname)
      return result !== -1 || this.showMessageBreadcrumb
    },
    showMessageBreadcrumb() {
      let routes = []

      if (this.message && this.message.id) {
        routes.push(this.$routes.edit_bucket_message(this.bucket, this.message))
      }

      if (this.recording && this.recording.id) {
        routes.push(this.$routes.new_bucket_recording_copy(this.bucket, this.recording))
        routes.push(this.$routes.new_bucket_recording_move(this.bucket, this.recording))
      }

      let result = routes.indexOf(location.pathname)
      return result !== -1
    },
    showTodoSetBreadcrumb() {
      let routes = []

      if (this.bucket && this.$page.todo_set) {
        routes.push(this.$routes.bucket_todo_list(this.bucket, this.$page.todo_set))
        routes.push(this.$routes.edit_bucket_todo_list(this.bucket, this.$page.todo_set))
      }
      let result = routes.indexOf(location.pathname)
      return result !== -1
    }
  },
  methods: {
  },
}
</script>

<style scoped="true" language="scss">
  .breadcrumb::after {
    content: '>';
    position: absolute;
    display: inline-block;
    width: 2em;
    text-align: center;
    top: 2px;
    @apply text-gray-100 text-xs;
  }

  .breadcrumb:last-child:after {
    content: '';
  }
</style>
