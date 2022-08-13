import { SeedArray } from './../MathTree/client/src/index';

export class SeedBank extends SeedArray {
	SUPABASE_URL: string;
	SUPABASE_ANON_KEY: string;
	constructor(props: number) {
		super(props);
		this.SUPABASE_URL = 'https://lvdramdykigglwcxsrhq.supabase.co/seeds?id=eq.';
		this.SUPABASE_ANON_KEY =
			'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYxOTUwMTU4OSwiZXhwIjoxOTM1MDc3NTg5fQ.fI9skHiu_jFXzs7boe4nMUXwoHwMdUE9a9hRfFpENE4';
	}
}

