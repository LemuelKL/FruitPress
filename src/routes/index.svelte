<script lang="ts">
	import Katex from '$lib/Katex.svelte';

	const Q1 = {
		id: 'DS2022D01',
		bank: 'HKDSE 2022',
		folder: 'HKDSE_Replica_Math_MC_2022',
		gene: {
			qn: '<p><span class="math-tex">\\(\\alpha^2+*c\\alpha+*d\\beta^2+*e\\beta\\)</span></p>\n\n<ul>\n\t<li><span class="math-tex">\\(\\left(\\alpha+*f\\beta\\right)\\left(\\alpha+*g\\beta+*h\\right)\\)</span></li>\n</ul>\n\n<p>&nbsp;</p>\n',
			sol: '<p><span class="math-tex">\\(\\alpha^2+*c\\alpha+*d\\beta^2+*e\\beta\\\\ =\\alpha^2+*d\\beta^2+*c\\alpha+*e\\beta\\\\ =(\\alpha+\\beta)(\\alpha-\\beta)+*i(\\alpha+*j\\beta) \\\\=\\left(\\alpha+*f\\beta\\right)\\left(\\alpha+*g\\beta+*h\\right)\\)</span></p>\n\n<p>&nbsp;</p>\n',
			populate:
				'a = 95734895739409;\r\nb = 92183128157;\r\n\r\nf = RndU()\r\ng = RndU()\r\nh = RndU()\r\n\r\nc = h\r\nd = f*g\r\ne = f * h\r\n\r\ni = c\r\nj = e/c\r\n\r\noptions = { f: [f, -f, -f], g:[g,-g,-g],h:[h,-h,-h]}\r\n',
			validate: 'd<0',
			preprocess: '',
			postprocess: '',
			remark: ''
		}
	};

	import jQuery from 'jquery';
	let raw_str = Q1.gene.qn;
	let katex_strs: string[] = [];

	const extract = () => {
		jQuery(raw_str).find('span.math-tex').each((i, e) => {
            katex_strs.push(e.innerText.replaceAll(/\\\(/g, '').replaceAll(/\\\)/g, ''));
            katex_strs = katex_strs
        });
	};
</script>

<div>
	{raw_str}

	<button class="btn btn-blue" on:click={extract}> Extract </button>

    {#each katex_strs as katex_str}
        <!-- {katex_str} -->
        <Katex math={katex_str} />
    {/each}
</div>

<!-- <Katex math={Q1.gene.qn}></Katex> -->
<style>
	.btn {
		@apply font-bold py-2 px-4 rounded;
	}
	.btn-blue {
		@apply bg-blue-500 text-white;
	}
	.btn-blue:hover {
		@apply bg-blue-700;
	}
</style>
