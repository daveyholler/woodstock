#!/bin/bash
# Simple ViewComponent Generator with visible progress
# Usage: ./generate_component.sh button

set -e

COMPONENT=$1

if [ -z "$COMPONENT" ]; then
  echo "Usage: $0 <component-name>"
  echo "Example: $0 button"
  exit 1
fi

# Convert component name formats
COMPONENT_CLASS=$(echo $COMPONENT | sed -r 's/(^|-)([a-z])/\U\2/g')
COMPONENT_VAR=$(echo $COMPONENT | tr '-' '_')

PROMPTS_DIR="./prompts"
CLAUDE_DIR="./claude/components"

echo "🚀 Generating ViewComponent: $COMPONENT"
echo "=" | head -c 80
echo ""

# Ensure directories exist
mkdir -p "$CLAUDE_DIR"
mkdir -p "./spec/components"
mkdir -p "./app/components"
mkdir -p "./app/javascript/controllers"

run_step() {
  local step=$1
  local desc=$2

  echo ""
  echo "▶️  $desc"
  echo "-" | head -c 80
  echo ""

  # Check if prompt file exists
  if [ ! -f "$PROMPTS_DIR/step-$step.md" ]; then
    echo "❌ Error: Prompt file not found: $PROMPTS_DIR/step-$step.md"
    return 1
  fi

  # Read prompt and replace placeholders
  PROMPT=$(cat "$PROMPTS_DIR/step-$step.md" | \
    sed "s/{COMPONENT_NAME}/$COMPONENT/g" | \
    sed "s/{ComponentName}/$COMPONENT_CLASS/g" | \
    sed "s/{component_name}/$COMPONENT_VAR/g")

  # Create temp file for prompt
  TEMP_PROMPT="/tmp/prompt-$step-$COMPONENT-$$.md"
  echo "$PROMPT" > "$TEMP_PROMPT"

  # Call Claude - output streams directly to terminal
  echo "🤖 Claude is working on this step..."
  echo ""

  # Use -p flag to pass prompt file, output goes straight to stdout
  if claude -p "$TEMP_PROMPT" 2>&1 | tee "$CLAUDE_DIR/step-$step-output.log"; then
    echo ""
    echo "✅ Step complete!"
  else
    echo ""
    echo "❌ Step failed!"
    rm -f "$TEMP_PROMPT"
    return 1
  fi

  # Clean up
  rm -f "$TEMP_PROMPT"
}

# Phase 1: Analysis
echo ""
echo "📊 PHASE 1: Analysis"
echo "=" | head -c 80

run_step "1a-component-classes" "Step 1a: Analyzing component structure"
run_step "1b-tailwind-requirements" "Step 1b: Extracting Tailwind requirements"
run_step "1c-api-analysis" "Step 1c: Documenting API & behavior"

# Phase 2: Generation
echo ""
echo ""
echo "🏗️  PHASE 2: Test-Driven Generation"
echo "=" | head -c 80

run_step "2a-rspec-generation" "Step 2a: Generating RSpec tests (TDD)"
run_step "2b-component-rb-generation" "Step 2b: Generating component.rb"
run_step "2c-erb-template-generation" "Step 2c: Generating ERB template"

# Check if we need Stimulus
if [ -f "$CLAUDE_DIR/$COMPONENT-api.md" ]; then
  if grep -qi "interactive\|toggle\|onClick\|keyboard\|open/closed" "$CLAUDE_DIR/$COMPONENT-api.md"; then
    run_step "2d-stimulus-controller-generation" "Step 2d: Generating Stimulus controller"
  else
    echo ""
    echo "⏭️  Skipping Stimulus controller (component is presentational)"
  fi
fi

run_step "2e-home-page-examples" "Step 2e: Adding examples to home page"

# Phase 3: Integration
echo ""
echo ""
echo "🔧 PHASE 3: Integration & Validation"
echo "=" | head -c 80
echo ""

echo "📝 Tailwind Configuration:"
if [ -f "$CLAUDE_DIR/$COMPONENT-tailwind.md" ]; then
  echo "   Review requirements: $CLAUDE_DIR/$COMPONENT-tailwind.md"
  echo "   Update tailwind.config.js manually if needed"
else
  echo "   ⚠️  No Tailwind requirements file found"
fi

# Run tests
echo ""
echo "🧪 Running Tests:"
SPEC_FILE="./spec/components/${COMPONENT_VAR}_component_spec.rb"
if [ -f "$SPEC_FILE" ]; then
  if bundle exec rspec "$SPEC_FILE" --format documentation; then
    echo ""
    echo "✅ All tests passed!"
  else
    echo ""
    echo "⚠️  Some tests failed - review and fix"
  fi
else
  echo "   ⚠️  Spec file not found: $SPEC_FILE"
fi

# Summary
echo ""
echo ""
echo "=" | head -c 80
echo "📦 Generation Complete!"
echo "=" | head -c 80
echo ""
echo "Generated files:"
echo "  Analysis:"
echo "    • $CLAUDE_DIR/$COMPONENT-layout.md"
echo "    • $CLAUDE_DIR/$COMPONENT-tailwind.md"
echo "    • $CLAUDE_DIR/$COMPONENT-api.md"
echo ""
echo "  Component:"
echo "    • ./spec/components/${COMPONENT_VAR}_component_spec.rb"
echo "    • ./app/components/${COMPONENT_VAR}_component.rb"
echo "    • ./app/components/${COMPONENT_VAR}_component.html.erb"

if [ -f "./app/javascript/controllers/${COMPONENT_VAR}_controller.js" ]; then
  echo "    • ./app/javascript/controllers/${COMPONENT_VAR}_controller.js"
fi

echo ""
echo "Next steps:"
echo "  1. Review generated files"
echo "  2. Update Tailwind config if needed"
echo "  3. Check examples at app/views/pages/home.html.erb"
echo "  4. Test in browser"
echo ""
echo "=" | head -c 80
echo ""
