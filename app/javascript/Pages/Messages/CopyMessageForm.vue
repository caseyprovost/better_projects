<template>
  <form @submit.prevent="$emit('submit')">
    <div class="px-4 pt-5 pb-2 flex">
      <select-input
        id="project_id"
        v-model="form.project_id"
        :errors="$page.errors.project_id"
        class="w-full"
        input-class="border-gray-900"
        placeholder="Type a title..."
        label="Choose where to put this copy"
        name="copy[project_id]"
      >
        <option
          v-for="project in projects"
          :key="project.id"
          :value="project.id"
        >
          {{ project.name }}
        </option>
      </select-input>
    </div>
    <slot />
  </form>
</template>

<script>
import SelectInput from '@/Components/SelectInput'

export default {
  components: {
    SelectInput,
  },
  props: {
    form: {
      type: Object,
      required: true,
    },
    projects: {
      type: Array,
      required: true,
    },
  },
}
</script>

<style scoped="true" language="scss">
</style>
