<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-6 flex flex-wrap">
      <text-input
        v-model="form.name"
        :errors="$page.errors.name"
        class="w-full"
        input-class="border-indigo-700"
        label="Name"
      />
      <text-area
        v-model="form.description"
        :errors="$page.errors.description"
        class="w-full"
        input-class="border-indigo-700 h-48"
        label="Description"
      />
    </div>
    <slot />
  </form>
</template>

<script>
import TextInput from '@/Components/TextInput'
import TextArea from '@/Components/TextArea'
export default {
  components: {
    TextInput,
    TextArea,
  },
  props: {
    form: {
      type: Object,
      required: true,
    },
  },
}
</script>
