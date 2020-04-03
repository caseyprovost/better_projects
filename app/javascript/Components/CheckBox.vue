<template>
  <div class="checkbox">
    <label :class="labelClasses"></label>
    <span class="checkbox__button"></span>
  </div>
</template>

<script>
  export default {
    props: {
      disabled: {
        type: Boolean,
        required: false,
        default: false
      }
    },
    computed: {
      labelClasses() {
        let classes = "checkbox__label"

        if (this.disabled) {
          classes += " checkbox__label--disabled"
        }

        return classes
      }
    }
  }
</script>

<style scoped="true" language="scss">
  .checkbox__button {
    display: inline-block;
    width: 1.4em;
    height: 1.4em;
    border: 1px solid rgba(0,0,0,0.25);
    background-color: #fff;
    border-radius: 0.3em;
    vertical-align: top;
  }
</style>
