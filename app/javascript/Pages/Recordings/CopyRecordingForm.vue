<template>
  <form @submit.prevent="$emit('submit')">
    <div class="px-4 pt-5 pb-2 flex">
      <select-input
        id="destination_bucket_id"
        v-model="form.destination_bucket_id"
        :errors="$page.errors.destination_bucket_id"
        class="w-full"
        input-class="border-gray-900"
        placeholder="Type a title..."
        label="Choose where to put this copy"
        name="copy[destination_bucket_id]"
      >
        <option
          v-for="bucket in buckets"
          :key="bucket.id"
          :value="bucket.id"
        >
          {{ bucket.name }}
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
    buckets: {
      type: Array,
      required: true,
    },
  },
}
</script>

<style scoped="true" language="scss">
</style>
