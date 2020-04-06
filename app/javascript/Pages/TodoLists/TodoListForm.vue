<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-2 flex flex-wrap">
      <text-input
        id="todo_list_title"
        v-model="form.title"
        :errors="$page.errors.title"
        class="w-full input-wrapper"
        placeholder="Name this list..."
      />
      <div class="w-full" v-if="!showDescription">
        <a href="#" @click.prevent="openDescription">Add extra details or attach a file</a>
      </div>
      <div class="w-full" v-if="showDescription">
        <VueTrix
          v-model="form.description"
          input-id="todo_list_description"
          input-name="todo_list[description]"
          class="w-full text-gray-400"
          input-class="h-48"
          placeholder="Write away..."
        />
        <div
          v-if="$page.errors && $page.errors.description && $page.errors.description.length"
          class="form-error"
        >
          {{ $page.errors.description.join(", ") }}
        </div>
      </div>
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
  data() {
    return {
      showDescription: false
    }
  },
  methods: {
    openDescription() {
      this.showDescription = true
    }
  }
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
    @apply text-gray-500 bg-gray-800 border border-indigo-800 !important;
  }

  trix-editor:empty:not(:focus)::before {
    @apply text-gray-500;
  }

  .input-wrapper {
    @apply mb-4 !important;
  }
</style>
