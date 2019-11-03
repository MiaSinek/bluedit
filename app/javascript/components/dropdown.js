// TODO: SVG icons should be white on hover

document.addEventListener("turbolinks:load", () => {
  const dropdown = document.querySelector(".js-dropdown-user-target");
  const dropdownList = document.querySelector(".dropdown-list");

  dropdown.addEventListener("click", (evt) => evt.preventDefault());

  document.addEventListener("click", (evt) => {
    if(evt.target.closest(".dropdown")) {
      // show dropdown if dropdown is clicked
      dropdownList.classList.remove("hidden");
    } else {
      // hide dropdown if outside of dropdown is clicked
      dropdownList.classList.add("hidden");
    }
  });
});