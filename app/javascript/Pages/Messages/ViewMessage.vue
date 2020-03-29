<template>
  <div>
    <div class="flex justify-center">
      <div class="w-full bg-gray-900 relative">
        <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full justify-between items-center">
          <h1 class="text-indigo-400 text-3xl w-full">
            {{ message.subject }}
          </h1>
          <a
            href="#"
            class="btn-circle-outline btn-circle-indigo text-sm w-8 h-8"
            @click.prevent="showActionsMenu"
          >
            <i class="fas fa-ellipsis-h" />
          </a>
        </div>
        <message-actions-popover
          :message="message"
          :opened="displayActions"
          @close="closeActions"
        />
      </div>
    </div>

    <div class="flex mt-4 bg-gray-900 p-8">
      <div
        class="trix-content text-gray-500"
        v-html="message.content.body"
      />
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import currentProject from '@/utils/currentProject'
import MessageActionsPopover from '@/Components/MessageActionsPopover'

export default {
  layout: Layout,
  components: {
    MessageActionsPopover,
  },
  mixins: [currentProject],
  props: {
    message: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      showActions: false,
    }
  },
  computed: {
    editMessagePath() {
      return this.$routes.edit_project_message(this.project, this.message)
    },
    displayActions() {
      return this.showActions
    },
  },
  methods: {
    showActionsMenu() {
      this.showActions = true
    },
    closeActions() {
      this.showActions = false
    },
  },
}
</script>
