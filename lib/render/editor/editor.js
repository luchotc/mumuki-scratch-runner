$(document).ready(function () {

  const preserveArrayFormat = function(k, v) {
    if (v instanceof Uint8Array) {
      return Array.apply([], v);
    }
    return v;
  };

  getScratchValue = function () {
    return JSON.stringify(scratchVm.asMumukiSolution(), preserveArrayFormat);
  };

  var scratchEditor = {
    getContent: function () {
      return { name: "solution[content]", value: getScratchValue() } ;
    }
  };

  function postpone(action) {
    return setTimeout(action, 500);
  }

  const initialize = () => {
    postpone(() => {
      if (typeof scratchVm === 'undefined') return initialize();
      loadInitialContent();
      if (typeof angular !== 'undefined') {
        syncContent();
        scratchVm.loadCurrentContent = function () {
          if(scratchVm.shouldRefreshContent) {
            scratchVm.loadMumukiSolution(getCurrentContent());
            scratchVm.shouldRefreshContent = false;
          }
        };
      }
      else {
        mumuki.CustomEditor.addSource(scratchEditor);
      }
    });
  };

  const getCurrentContent = function () {
    let editorDefaultValue = getEditorDefaultValue();
    return getEditorValue().value || editorDefaultValue && editorDefaultValue.value;
  };

  const syncContent = function() {
    scratchVm.on('PROJECT_CHANGED', () => {
      let editorValue = getEditorValue();
      editorValue.value = getScratchValue();
      angular.element(editorValue).triggerHandler("change");
    });
    $(window).on('hashchange', () => {
      scratchVm.shouldRefreshContent = true;
    });
  };

  const loadInitialContent = function() {
    let initialContent = getCurrentContent();
    if(initialContent) {
      scratchVm.loadedExternally = true;
      scratchVm.loadMumukiSolution(initialContent);
    }
  };

  // TODO: expose this functions as part of Mumuki's interface

  function getEditorValue() {
    return $("#mu-custom-editor-value")[0];
  }

  function getEditorDefaultValue() {
    return $("#mu-custom-editor-default-value")[0];
  }

  initialize();
});
