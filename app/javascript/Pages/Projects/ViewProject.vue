<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
          <h1 class="text-indigo-400 text-3xl w-full">
            {{ project.name }}
          </h1>
        </div>
      </div>
    </div>

    <div class="flex mt-8">
      <div class="w-full flex-wrap flex md:justify-between">
        <dashboard-tile
          title="Message Board"
          :empty="messages.length === 0"
          icon-color="blue"
          icon="sticky-note"
          empty-text="Post accouncements, pitch ideas, progress updates, etc. Keep feedback on topic."
          :href="messageBoardPath"
        >
          <template v-slot:full>
            <ul class="w-full">
              <li
                v-for="message in messages"
                :key="message.id"
                class="mb-4 text-gray-400"
              >
                <p>{{ message.subject }}</p>
                <div>{{ truncate(message.content_preview, 30) }}</div>
              </li>
            </ul>
          </template>
        </dashboard-tile>
        <dashboard-tile
          :href="todoListsPath"
          title="To-dos"
          :empty="todoLists.length === 0"
          icon-color="green"
          icon="check"
          empty-text="Make lists of work to be done, assign items, due dates, and discuss"
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">
              Full
            </p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          :href="documentsPath"
          title="Docs & Files"
          :empty="documents.length === 0"
          icon-color="orange"
          icon="upload"
          empty-text="Share docs, files, images, and even spreadsheets. Organize in folders so that they're easy to find."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">
              Full
            </p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          :href="chatsPath"
          title="Fireside Chat"
          :empty="chats.length === 0"
          icon-color="pink"
          icon="comments"
          empty-text="Chat casually with the group, ask random questions, and share stuff without ceremony."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">
              Full
            </p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          :href="questionsPath"
          title="Automatic Check-ins"
          :empty="checkIns.length === 0"
          icon-color="purple"
          icon="question"
          empty-text="Create recurring questions so you don't have to pester your team about what's going on."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">
              Full
            </p>
          </template>
        </dashboard-tile>
        <dashboard-tile
          :href="budgetPath"
          title="Budget"
          :empty="checkIns.length === 0"
          icon-color="teal"
          icon="dollar-sign"
          empty-text="Keep track of your project's expenses and get approvals on important budget updates."
        >
          <template v-slot:full>
            <p class="text-indigo-100 w-full text-center">
              Full
            </p>
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
      default: () => [],
    },
    documents: {
      type: Array,
      default: () => [],
    },
    chats: {
      type: Array,
      default: () => [],
    },
    todoLists: {
      type: Array,
      default: () => [],
    },
    checkIns: {
      type: Array,
      default: () => [],
    },
    activities: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
    }
  },
  computed: {
    messageBoardPath() {
      if (this.messages.length === 0) {
        return this.$routes.new_project_message(this.project)
      } else {
        return this.$routes.project_message_board(this.project)
      }
    },
    todoListsPath() {
      if (this.todoLists.length === 0) {
        return this.$routes.new_project_todo_list(this.project)
      } else {
        return this.$routes.project_todo_lists(this.project)
      }
    },
    documentsPath() {
      // return this.$routes.project_todo_lists(this.project)
      return ''
    },
    chatsPath() {
      // return this.$routes.project_todo_lists(this.project)
      return ''
    },
    questionsPath() {
      // return this.$routes.project_todo_lists(this.project)
      return ''
    },
    budgetPath() {
      // return this.$routes.project_todo_lists(this.project)
      return ''
    },
  },
  methods: {
    truncate(string, max) {
      return string.length > max ? string.substr(0, max-1) + '…' : string
    },
  },
}
</script>
