<script lang="ts">
	import { SeedBank } from '$lib/seedbank';

	const seedBank = new SeedBank(45);

	seedBank.refreshByIds(['DS2022D01', 'DS2022D02']).then(() => {
		console.log('hi');
	});
</script>

<div />
