<template>
  <form @submit.prevent="$emit('submit')">
    <div class="p-2 flex flex-wrap w-full">
      <div class="flex w-40 justify-end pr-2">
        <fancy-check-box class="mt-3" />
      </div>
      <div class="w-1/2 items-center">
        <text-input
          id="todo_title"
          v-model="form.title"
          :errors="$page.errors.title"
          class="w-full input-wrapper"
          placeholder="Describe this to-do..."
          inputClass=""
        />
      </div>
      <div class="w-full flex items-center mb-4">
        <label class="text-gray-400 w-40 text-right pr-2">Assigned To: </label>
        <div class="w-1/2 items-center">
          <multiselect
            v-model="form.assignees"
            :options="assigneeOptions"
            :multiple="true"
            :searchable="true"
            :close-on-select="true"
            placeholder="Type names to assign..."
            label="name"
            trackBy="id"
          >
          </multiselect>
        </div>
      </div>
      <div class="w-full flex items-center mb-4">
        <label class="text-gray-400 w-40 text-right pr-2">When done, notify</label>
        <div class="w-1/2">
          <multiselect
            v-model="form.notifiees"
            :options="notifieeOptions"
            :multiple="true"
            :searchable="true"
            :close-on-select="true"
            placeholder="Type names to assign..."
            label="name"
            trackBy="id"
          >
          </multiselect>
        </div>
      </div>
      <div class="w-full flex mb-4">
        <label class="text-gray-400 w-40 text-right pr-2">Due On</label>
        <div class="w-4/6">
          <a href="#" @click.prevent="showDueOn = true" v-if="!showDueOn">Select a date...</a>
          <div v-if="showDueOn">
            <div class="flex">
              <radio-button
                id="todo_no_due_date"
                class="input-wrapper"
                label="No due date"
                :value="null"
                value="none"
                name="due_date_type"
                :checked="dueDateType == 'none'"
                @change="selectDateType"
              />
            </div>
            <div class="flex">
              <radio-button
                id="todo_due_date_single"
                :errors="$page.errors.due_on"
                class="input-wrapper"
                label="A specific day"
                value="single"
                name="due_date_type"
                @change="selectDateType"
              >
                <vc-date-picker
                  mode="single"
                  :value="null"
                  color="red"
                  is-dark
                  :input-props='{placeholder: "Pick a date..."}'
                  :popover="{ visibility: 'click' }"
                  v-model="form.due_on"
                  v-if="dueDateType === 'single'"
                />
              </radio-button>
            </div>
            <div class="flex items-center">
              <radio-button
                id="todo_due_date_range"
                :errors="$page.errors.due_on"
                class="input-wrapper"
                label="Runs for multiple days"
                value="range"
                name="due_date_type"
                @change="selectDateType"
              >
                <div class="w-40">
                  <vc-date-picker
                    mode="single"
                    color="red"
                    is-dark
                    :input-props='{placeholder: "Pick start date.."}'
                    :popover="{ visibility: 'click' }"
                    v-model="form.starts_on"
                    v-if="dueDateType === 'range'"
                  />
                </div>

                <div class="inline-flex items-center mx-2" v-if="dueDateType === 'range'">
                  <span>and</span>
                </div>

                <div class="w-40">
                  <vc-date-picker
                    mode="single"
                    color="red"
                    is-dark
                    :input-props='{placeholder: "Pick an end date.."}'
                    :popover="{ visibility: 'click' }"
                    v-model="form.due_on"
                    v-if="dueDateType === 'range'"
                  />
                </div>
              </radio-button>
            </div>
          </div>
        </div>
        <div
          v-if="$page.errors && $page.errors.due_on && $page.errors.due_on.length"
          class="form-error"
        >
          {{ $page.errors.due_on.join(", ") }}
        </div>
      </div>
      <div class="w-full flex mb-4">
        <label class="text-gray-400 w-40 text-right pr-2">Notes</label>
        <div class="w-1/2">
          <VueTrix
            v-model="form.description"
            input-id="todo_description"
            input-name="todo[description]"
            class="w-full text-gray-400"
            input-class="h-48"
            placeholder="Add extra details or attach a file..."
            label="name"
            trackBy="id"
            v-if="showDescription"
          />
          <a href="#" @click.prevent="showDescription = true" v-if="!showDescription">
            Add extra details or attach a file...
          </a>
        </div>
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
import RadioButton from '@/Components/RadioButton'
import FancyCheckBox from '@/Components/FancyCheckBox'
import TextArea from '@/Components/TextArea'
import VueTrix from 'vue-trix'
import Multiselect from 'vue-multiselect'

export default {
  components: {
    TextInput,
    TextArea,
    VueTrix,
    Multiselect,
    RadioButton,
    FancyCheckBox
  },
  props: {
    form: {
      type: Object,
      required: true,
    },
    assignees: {
      type: Array,
      default: []
    },
    notifiees: {
      type: Array,
      default: []
    },
  },
  data() {
    return {
      showDescription: false,
      showDueOn: false,
      dueDateType: "none"
    }
  },
  methods: {
    openDescription() {
      this.showDescription = true
    },
    selectDateType(data) {
      this.dueDateType = data
      this.form.due_on = null
      this.form.starts_on = null
    }
  },
  computed: {
    assigneeOptions() {
      return this.assignees.map((user) => {
        return {
          id: user.id,
          name: user.name
        }
      })
    },
    notifieeOptions() {
      return this.notifiees.map((user) => {
        return {
          id: user.id,
          name: user.name
        }
      })
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
