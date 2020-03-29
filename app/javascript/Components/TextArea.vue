<template>
  <div class="mb-6">
    <label
      v-if="label"
      class="form-label"
      :for="id"
    >{{ label }}:</label>
    <textarea
      :id="id"
      ref="input"
      v-bind="$attrs"
      :class="inputClasses"
      :value="value"
      @input="$emit('input', $event.target.value)"
    />
    <div
      v-if="errors.length"
      class="form-error"
    >
      {{ errors.join(", ") }}
    </div>
  </div>
</template>

<script>
export default {
  inheritAttrs: false,
  props: {
    id: {
      default() {
        return `text-input-${this._uid}`
      },
    },
    inputClass: {
      type: String,
      default: '',
    },
    value: {
      type: String,
      default: null,
    },
    label: {
      type: String,
      default: null,
    },
    errors: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    inputClasses() {
      let classes = `${this.inputClass} form-textarea`

      if (this.errors.length > 0) {
        classes += ' error'
      }

      return classes
    },
  },
  methods: {
    focus() {
      this.$refs.input.focus()
    },
    select() {
      this.$refs.input.select()
    },
    setSelectionRange(start, end) {
      this.$refs.input.setSelectionRange(start, end)
    },
  },
}
</script>
