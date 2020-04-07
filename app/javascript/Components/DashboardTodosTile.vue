<template>
  <dashboard-tile
    :href="href"
    title="To-dos"
    :empty="todoLists.length === 0"
    icon-color="green"
    icon="check"
    empty-text="Make lists of work to be done, assign items, due dates, and discuss"
  >
    <template v-slot:full>
      <ul class="w-full object-fit">
        <li
          v-for="todoList in todoLists"
          :key="todoList.id"
          class="mb-4 text-gray-400 flex flex-wrap"
        >
          <div class="text-sm w-full">
            <p class="font-semibold w-full">
              {{ todoList.title }}
            </p>
          </div>

          <div v-if="todoList.todos.length > 0" class="w-full mt-2">
            <div v-for="todo in todoList.todos" class="ml-1 flex mb-1">
              <label class="inline-flex items-center">
                <input type="checkbox" class="form-checkbox text-pink-600 h-3 w-3 border border-pink-600 bg-transparent" :checked="todo.completed">
                <span class="ml-2">{{ todo.title }}</span>
              </label>
            </div>
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
      todoLists: {
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
