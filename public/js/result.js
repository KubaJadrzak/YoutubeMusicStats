const toggleBtn = document.getElementById('toggleBtn');
      const artistTable = document.getElementById('artistTable');
      const songTable = document.getElementById('songTable');
      const searchInput = document.getElementById('searchInput');

      toggleBtn.addEventListener('click', () => {
        if (artistTable.style.display !== 'none') {
          artistTable.style.display = 'none';
          songTable.style.display = 'block';
          toggleBtn.textContent = 'Show Artists';
          searchInput.value = '';
        } else {
          artistTable.style.display = 'block';
          songTable.style.display = 'none';
          toggleBtn.textContent = 'Show Songs';
          searchInput.value = '';
        }
      });

      searchInput.addEventListener('input', () => {
        const filter = searchInput.value.toLowerCase();
        const activeTable = artistTable.style.display !== 'none' ? artistTable : songTable;
        const rows = activeTable.querySelectorAll('tbody tr');

        rows.forEach(row => {
          const text = row.cells[0].textContent.toLowerCase();
          row.style.display = text.includes(filter) ? '' : 'none';
        });
      });