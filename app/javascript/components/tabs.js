// TODO: Make this page-specific and only load for submissions/new+edit

document.addEventListener('turbolinks:load', () => {
  const tabs = document.querySelectorAll('li[role=tab]');

  const post = document.querySelector('.post');
  const imageVideo = document.querySelector('.image_video');
  const url = document.querySelector('.url');

  if (imageVideo != null) {
    imageVideo.classList.add('hidden');
    url.classList.add('hidden');
  }
  
  function onTabClick(event) {
    const activeTabs = document.querySelectorAll('.active');

    activeTabs.forEach(function(tab) {
      tab.classList.toggle('active');
    });
    // activate new tab and panel
    event.currentTarget.classList.add('active');
    event.preventDefault();
  }

  function hidePostSpecificAreas() {
    imageVideo.classList.add('hidden');
    url.classList.add('hidden');
    post.classList.add('hidden');
  }

  function determineType(event) {
    hidePostSpecificAreas();

    // Post
    if (event.currentTarget.dataset.tab == "post") {
      post.classList.remove('hidden');

      url.querySelector("input[type=text]").value = "";
    }

    // Image / Video
    if (event.currentTarget.dataset.tab == "image_video") {
      imageVideo.classList.remove('hidden');

      post.querySelector("textarea").value = "";
      url.querySelector("input[type=text]").value = "";
    }

    // URL
    if (event.currentTarget.dataset.tab == "url") {
      url.classList.remove('hidden');

      post.querySelector("textarea").value = "";
    }
  }

  tabs.forEach( (tab) => {
    tab.addEventListener('click', function(event) {
      onTabClick(event);
      determineType(event);
    });
  })

});
