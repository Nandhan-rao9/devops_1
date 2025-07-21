
# 🚦 CI Pipeline: Automated Linting & Testing

## 📝 Problem Statement

Manual code reviews can miss errors and bugs, letting broken or badly styled code slip into the main branch.
**Goal:** Ensure only clean, tested code is merged.

---

## 💡 Solution

Set up a **Continuous Integration (CI) pipeline** with GitHub Actions to:

* **Lint** Python code with flake8 to catch style and syntax issues automatically.
* **Run unit tests** with pytest to verify code correctness.
* **Block merges** if code quality or tests fail.

---

## 🔄 Workflow

1. Push or open a pull request to `main`
2. CI workflow runs:
    → Lints code
    → Runs tests
3. **All checks pass?**
   ✅ Code can be merged
   ❌ Fix errors and try again

---

## 📂 Project Structure

```
/Projects/4.1.linting_and_testing/
    calculator.py
    test_calculator.py
/requirements.txt
```

---

## 🌟 Result

Every change is checked instantly—**no more broken or messy code in main!**

