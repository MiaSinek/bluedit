// app/javascript/components/dropdown.js
document.addEventListener("turbolinks:load", () => {

  function dropdown() {
    const dropDownLinks = document.querySelectorAll('.js-nav .dropdown a.dropdown-target');

    dropDownLinks.forEach(function(dropdown) {
      dropdown.addEventListener('click', function(event) {

        const dropdownTarget = event.currentTarget.nextElementSibling;

        // toggle dropdown
        dropdownTarget.classList.toggle('hidden');
        // hide dropdown when clicking outside the dropdown area
        hideOnClickOutside(event.currentTarget);
        event.preventDefault();
      });
    });
  }

  // TODO Refactor this - it is a mess!
  // We should attach the event outsideClickListener if any of the dropdowns are open
  // otherwise (when the dropdowns have been closed) remove it
  function hideOnClickOutside(element) {
    const outsideClickListener = function(event) {
      if (!element.contains(event.target)) {
        if (!!element && !!(element.offsetWidth || element.offsetHeight || element.getClientRects().length)) {
          element.nextElementSibling.classList.toggle('hidden');
          removeClickListener();
        }
      }
    }

    const removeClickListener = function() {
      document.removeEventListener('click', outsideClickListener);
    }

    document.addEventListener('click', outsideClickListener);
  }

function init() {
  dropdown();
}

init();
});