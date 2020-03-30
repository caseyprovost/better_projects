<template>
  <div v-if="project" class="bg-gray-700 py-2 px-3">
    <div class="breadcrumb relative inline-block pr-2">
      <inertia-link
        :href="this.$routes.project(project)"
        class="text-gray-100 underline hover:text-green-400 font-semibold"
      >
        {{ project.name }}
      </inertia-link>
    </div>
    <div
      v-if="onMessageBoard"
      class="breadcrumb relative inline-block pr-2"
    >
      <inertia-link
        :href="this.$routes.project(project)"
        class="text-gray-100 underline hover:text-green-400 ml-2"
      >
        Message Board
      </inertia-link>
    </div>
    <div
      v-if="inMessages"
      class="breadcrumb relative inline-block pr-2"
    >
      <inertia-link
        :href="this.$routes.project_message(project, message)"
        class="text-gray-100 underline hover:text-green-400 ml-2"
      >
        {{ message.subject }}
      </inertia-link>
    </div>
  </div>
</template>

<script>

export default {
  components: {
  },
  data() {
    return {
    }
  },
  props: {
    message: {
      type: Object,
      required: false,
      default: null
    },
    project: {
      type: Object,
      required: false,
      default: null
    }
  },
  computed: {
    inMessages() {
      return location.pathname.includes('messages/')
    },
    onMessageBoard() {
      return location.pathname.includes('message_board') ||
        location.pathname.includes('messages/')
    },
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
