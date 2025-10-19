const fileInput = document.getElementById('fileInput');
const uploadBtn = document.getElementById('uploadBtn');
const form = document.getElementById('uploadForm');

uploadBtn.addEventListener('click', () => fileInput.click());
fileInput.addEventListener('change', () => {
  if (fileInput.files.length > 0) {
    uploadBtn.innerHTML = 'Processing...<br><small>(This can take even a few minutes)</small>';
    uploadBtn.disabled = true;
    uploadBtn.style.opacity = '0.6';
    form.submit();
  };
});
