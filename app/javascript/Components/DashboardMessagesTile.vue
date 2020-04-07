<template>
  <dashboard-tile
    title="Message Board"
    :empty="messages.length === 0"
    icon-color="blue"
    icon="sticky-note"
    empty-text="Post accouncements, pitch ideas, progress updates, etc. Keep feedback on topic."
    :href="href"
  >
    <template v-slot:full>
      <ul class="w-full">
        <li
          v-for="message in messages"
          :key="message.id"
          class="mb-4 text-gray-400 flex"
        >
          <div class="rounded-full bg-blue-600 text-blue-100 flex h-8 text-sm w-8 justify-center items-center">
            <span>{{ userInitials(message.creator) }}</span>
          </div>
          <div class="text-sm ml-2 my-auto flex flex-wrap">
            <p class="font-semibold w-full">
              {{ message.subject }}
            </p>
            <p class="w-full">
              {{ truncate(message.content_preview, 30) }}
            </p>
          </div>
        </li>
      </ul>
    </template>
  </dashboard-tile>
</template>

<script>
  import DashboardTile from '@/Components/DashboardTile'

  export default {
    components: {
      DashboardTile
    },
    props: {
      messages: {
        type: Array,
        required: true
      },
      href: {
        type: String,
        required: true
      }
    },
    methods: {
      userInitials(user) {
        let parts = user.name.split(' ')
        return parts.map(p => p[0]).join('')
      },
      truncate(string, max) {
        return string.length > max ? string.substr(0, max-1) + '…' : string
      }
    },
  }
</script>
