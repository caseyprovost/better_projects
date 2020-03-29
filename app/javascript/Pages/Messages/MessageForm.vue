<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-6 flex flex-wrap">
      <text-input
        v-model="form.subject"
        :errors="$page.errors.subject"
        class="w-full"
        input-class="border-gray-900"
        placeholder="Type a title..."
      />
      <VueTrix
        v-model="form.content"
        input-id="message_content"
        :errors="$page.errors.content"
        class="w-full"
        input-class="border-gray-900 h-48"
        placeholder="Write away..."
      />
    </div>
    <slot />
  </form>
</template>

<script>
import TextInput from '@/Components/TextInput'
import TextArea from '@/Components/TextArea'
import VueTrix from 'vue-trix'

export default {
  components: {
    TextInput,
    TextArea,
    VueTrix,
  },
  props: {
    form: {
      type: Object,
      required: true,
    },
  },
}
</script>

<style>
  .trix-button-group.trix-button-group--text-tools {
    @apply border-purple-500;
  }

  button.trix-button.trix-button--icon {
    @apply border-purple-800 bg-purple-500;
  }

  .trix-button.trix-button--icon.trix-active {
    @apply bg-pink-500;
  }

  trix-editor {
    @apply text-indigo-100;
  }
</style>
