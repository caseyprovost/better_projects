<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">{{ project.name }}</h1>
        </div>
      </div>
    </div>

    <div class="flex mt-8">
      <div class="w-full flex-wrap flex">
        <dashboard-tile
          title="Message Board"
          :empty="noMessages"
          iconColor="blue"
          icon="sticky-note"
          emptyText="Post accouncements, pitch ideas, progress updates, etc. Keep feedback on topic."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">Full</p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          title="Message Board"
          :empty="noTodos"
          iconColor="green"
          icon="check"
          emptyText="Make lists of work to be done, assign items, due dates, and discuss"
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">Full</p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          title="Docs & Files"
          :empty="noDocuments"
          iconColor="orange"
          icon="upload"
          emptyText="Share docs, files, images, and even spreadsheets. Organize in folders so that they're easy to find."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">Full</p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          title="Fireside Chat"
          :empty="noChats"
          iconColor="pink"
          icon="comments"
          emptyText="Chat casually with the group, ask random questions, and share stuff without ceremony."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">Full</p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          title="Automatic Check-ins"
          :empty="checkIns.length === 0"
          iconColor="purple"
          icon="question"
          emptyText="Create recurring questions so you don't have to pester your team about what's going on."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">Full</p>
          </template>
        </dashboard-tile>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import DashboardTile from '@/Components/DashboardTile'

export default {
  metaInfo: { title: 'Account Dashboard' },
  layout: Layout,
  components: {
    DashboardTile,
  },
  props: {
    project: Object,
    messages: {
      type: Array,
      default: () => []
    },
    documents: {
      type: Array,
      default: () => []
    },
    chats: {
      type: Array,
      default: () => []
    },
    todos: {
      type: Array,
      default: () => []
    },
    checkIns: {
      type: Array,
      default: () => []
    },
    activities: {
      type: Array,
      default: () => []
    },
  },
  data() {
    return {
    }
  },
  computed: {
    noMessages() {
      return this.messages.length === 0
    },
    noTodos() {
      return this.todos.length === 0
    },
    noDocuments() {
      return this.documents.length === 0
    },
    noChats() {
      return this.chats.length === 0
    }
  },
  methods: {
  },
}
</script>
