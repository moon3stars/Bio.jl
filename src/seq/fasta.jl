# WARNING: This file was generated from fasta.rl using ragel. Do not edit!
# FASTA sequence types

immutable FASTA <: FileFormat end


	"Metadata for FASTA sequence records containing just a `description` field"
	type FASTAMetadata
	description::StringField
	end


function FASTAMetadata()
	return FASTAMetadata(StringField())
	end


function (==)(a::FASTAMetadata, b::FASTAMetadata)
	return a.description == b.description
	end


function copy(metadata::FASTAMetadata)
	return FASTAMetadata(copy(metadata.description))
	end


"FASTASeqRecord{S} is a `SeqRecord` for FASTA sequences of type `S`"
typealias FASTASeqRecord           SeqRecord{Sequence, FASTAMetadata}

"A `SeqRecord` type for FASTA DNA sequences"
typealias FASTADNASeqRecord       DNASeqRecord{FASTAMetadata}

"A `SeqRecord` type for FASTA RNA sequences"
typealias FASTARNASeqRecord       RNASeqRecord{FASTAMetadata}

"A `SeqRecord` type for FASTA amino acid sequences"
typealias FASTAAminoAcidSeqRecord AminoAcidSeqRecord{FASTAMetadata}


function show{	S}(io::IO, seqrec::SeqRecord{S, FASTAMetadata})
write(io, ">", seqrec.name, " ", seqrec.metadata.description, "\n")
show(io, seqrec.seq)
end


	"Writes a FASTASeqRecord to an IO-stream (and obeys FASTAs max character constraint)"
	function 	Base.write{T}(io::IO, seqrec::SeqRecord{T, FASTAMetadata})
	write(io, ">", seqrec.name)
	if !isempty(seqrec.metadata.description)
		write(io, " ", seqrec.metadata.description)
	end
	write(io, "\n")
	maxchars = 79
	counter = 1
	len = length(seqrec.seq)
	for nt in seqrec.seq
	show(io, nt)
	if counter % maxchars == 0 && counter < len
		write(io, "\n")
	end
	counter += 1
end
write(io, "\n")
end


const _fastaparser_start  = 6
const _fastaparser_first_final  = 6
const _fastaparser_error  = 0
const _fastaparser_en_main  = 6
const __fastaparser_nfa_targs = Int8[ 0, 0 ,  ]
const __fastaparser_nfa_offsets = Int8[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,  ]
const __fastaparser_nfa_push_actions = Int8[ 0, 0 ,  ]
const __fastaparser_nfa_pop_trans = Int8[ 0, 0 ,  ]
"A type encapsulating the current state of a FASTA parser"
	type FASTAParser <: AbstractParser
	state::Ragel.State
	seqbuf::BufferedOutputStream{	BufferedStreams.EmptyStreamSource}
default_alphabet::Alphabet

function FASTAParser(input::BufferedInputStream)
	begin
	cs = convert( Int , _fastaparser_start );

end
return new(Ragel.State(cs, input), BufferedOutputStream(), DNA_ALPHABET)
end
	end


function eltype(::Type{	FASTAParser})
return FASTASeqRecord
end


	function 	open(input::BufferedInputStream, ::Type{FASTA})
	return FASTAParser(input)
end


typealias FASTAAnySeqRecord{S} SeqRecord{S, FASTAMetadata}

Ragel.@generate_read_fuction("_fastaparser", FASTAParser, FASTAAnySeqRecord,
begin
begin
if ( p == pe  )
	@goto _test_eof

end
if ( cs  == 6 )
	@goto st_case_6
elseif ( cs  == 0 )
	@goto st_case_0
elseif ( cs  == 1 )
	@goto st_case_1
elseif ( cs  == 2 )
	@goto st_case_2
elseif ( cs  == 3 )
	@goto st_case_3
elseif ( cs  == 4 )
	@goto st_case_4
elseif ( cs  == 7 )
	@goto st_case_7
elseif ( cs  == 8 )
	@goto st_case_8
elseif ( cs  == 5 )
	@goto st_case_5
end
@goto st_out
@label ctr13
begin
state.linenum += 1
end
@goto st6
@label st6
p+= 1;
if 	( p == pe  )
	@goto _test_eof6

end
@label st_case_6
if ( (data[1+(p )]) == 10 )
	begin
	@goto ctr13

end
elseif 	( (data[1+(p )]) == 32 )
	begin
	@goto st6

end
elseif 	( (data[1+(p )]) == 62 )
	begin
	@goto st1

end
end
if 	( 9 <= (data[1+(p )])&& (data[1+(p )])<= 13  )
	begin
	@goto st6

end

end
begin
	@goto st0

end
@label st_case_0
@label st0
cs = 0;
@goto _out
@label ctr17
begin
if seqtype(typeof(output)) == Sequence
		alphabet = infer_alphabet(input.seqbuf.buffer, 1,
		length(input.seqbuf), input.default_alphabet)
		ET = alphabet_type[alphabet]
		if 	ET == typeof(output.seq)
	copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
else
	output.seq = ET(input.seqbuf.buffer, 1, length(input.seqbuf),
	mutable=true)
end
input.default_alphabet = alphabet
else
			copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
end
empty!(input.seqbuf)
yield = true;
begin
p+= 1;
cs = 1;
@goto _out

end

end
@goto st1
@label ctr21
begin
Ragel.@append_from_anchor!(input.seqbuf)
end
begin
if seqtype(typeof(output)) == Sequence
alphabet = infer_alphabet(input.seqbuf.buffer, 1,
length(input.seqbuf), input.default_alphabet)
ET = alphabet_type[alphabet]
if ET == typeof(output.seq)
		copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
		else
output.seq = ET(input.seqbuf.buffer, 1, length(input.seqbuf),
		mutable=true)
		end
input.default_alphabet = alphabet
else
copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
end
empty!(input.seqbuf)
yield = true;
begin
p+= 1;
cs = 1;
@goto _out

end

end
@goto st1
@label st1
p+= 1;
if ( p == pe  )
@goto _test_eof1

end
@label st_case_1
if ( (data[1+(p )])== 32  )
begin
@goto st0

end

end
if ( 9 <= (data[1+(p )])&& (data[1+(p )])<= 13  )
begin
@goto st0

end

end
begin
@goto ctr0

end
@label ctr0
begin
Ragel.@anchor!
end
@goto st2
@label st2
p+= 1;
if ( p == pe  )
@goto _test_eof2

end
@label st_case_2
if ( (data[1+(p )]) == 10 )
begin
@goto ctr4

end
elseif ( (data[1+(p )]) == 12 )
begin
@goto st0

end
elseif ( (data[1+(p )]) == 13 )
begin
@goto ctr5

end
elseif ( (data[1+(p )]) == 32 )
begin
@goto ctr3

end
end
if ( 9 <= (data[1+(p )])&& (data[1+(p )])<= 11  )
begin
@goto ctr3

end

end
begin
@goto st2

end
@label ctr3
begin
Ragel.@copy_from_anchor!(output.name)
end
@goto st3
@label st3
p+= 1;
if ( p == pe  )
@goto _test_eof3

end
@label st_case_3
if ( (data[1+(p )]) == 9 )
begin
@goto st3

end
elseif ( (data[1+(p )]) == 11 )
begin
@goto st3

end
elseif ( (data[1+(p )]) == 32 )
begin
@goto st3

end
end
begin
@goto ctr6

end
@label ctr6
begin
Ragel.@anchor!
end
@goto st4
@label st4
p+= 1;
if ( p == pe  )
@goto _test_eof4

end
@label st_case_4
if ( (data[1+(p )]) == 10 )
begin
@goto ctr9

end
elseif ( (data[1+(p )]) == 13 )
begin
@goto ctr10

end
end
begin
@goto st4

end
@label ctr4
begin
Ragel.@copy_from_anchor!(output.name)
end
begin
state.linenum += 1
end
@goto st7
@label ctr9
begin
Ragel.@copy_from_anchor!(output.metadata.description)
end
begin
state.linenum += 1
end
@goto st7
@label ctr11
begin
state.linenum += 1
end
@goto st7
@label ctr19
begin
Ragel.@append_from_anchor!(input.seqbuf)
end
@goto st7
@label ctr20
begin
Ragel.@append_from_anchor!(input.seqbuf)
end
begin
state.linenum += 1
end
@goto st7
@label st7
p+= 1;
if ( p == pe  )
@goto _test_eof7

end
@label st_case_7
if ( (data[1+(p )]) == 10 )
begin
@goto ctr11

end
elseif ( (data[1+(p )]) == 32 )
begin
@goto st7

end
elseif ( (data[1+(p )]) == 62 )
begin
@goto ctr17

end
end
if ( 9 <= (data[1+(p )])&& (data[1+(p )])<= 13  )
begin
@goto st7

end

end
begin
@goto ctr15

end
@label ctr15
begin
Ragel.@anchor!
end
@goto st8
@label st8
p+= 1;
if ( p == pe  )
@goto _test_eof8

end
@label st_case_8
if ( (data[1+(p )]) == 10 )
begin
@goto ctr20

end
elseif ( (data[1+(p )]) == 32 )
begin
@goto ctr19

end
elseif ( (data[1+(p )]) == 62 )
begin
@goto ctr21

end
end
if ( 9 <= (data[1+(p )])&& (data[1+(p )])<= 13  )
begin
@goto ctr19

end

end
begin
@goto st8

end
@label ctr5
begin
Ragel.@copy_from_anchor!(output.name)
end
@goto st5
@label ctr10
begin
Ragel.@copy_from_anchor!(output.metadata.description)
end
@goto st5
@label st5
p+= 1;
if ( p == pe  )
@goto _test_eof5

end
@label st_case_5
if ( (data[1+(p )])== 10  )
begin
@goto ctr11

end

end
begin
@goto st0

end
@label st_out
@label _test_eof6
cs = 6;
@goto _test_eof
@label _test_eof1
cs = 1;
@goto _test_eof
@label _test_eof2
cs = 2;
@goto _test_eof
@label _test_eof3
cs = 3;
@goto _test_eof
@label _test_eof4
cs = 4;
@goto _test_eof
@label _test_eof7
cs = 7;
@goto _test_eof
@label _test_eof8
cs = 8;
@goto _test_eof
@label _test_eof5
cs = 5;
@goto _test_eof
@label _test_eof
begin

end
if ( p == eof  )
begin
if ( cs  == 7 )
begin
if seqtype(typeof(output)) == Sequence
alphabet = infer_alphabet(input.seqbuf.buffer, 1,
length(input.seqbuf), input.default_alphabet)
ET = alphabet_type[alphabet]
if ET == typeof(output.seq)
copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
else
output.seq = ET(input.seqbuf.buffer, 1, length(input.seqbuf),
mutable=true)
end
input.default_alphabet = alphabet
else
copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
end
empty!(input.seqbuf)
yield = true;
begin
p+= 1;
cs = 0;
@goto _out

end

end

break;
elseif ( cs  == 8 )
begin
Ragel.@append_from_anchor!(input.seqbuf)
end
begin
if seqtype(typeof(output)) == Sequence
alphabet = infer_alphabet(input.seqbuf.buffer, 1,
length(input.seqbuf), input.default_alphabet)
ET = alphabet_type[alphabet]
if ET == typeof(output.seq)
copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
else
output.seq = ET(input.seqbuf.buffer, 1, length(input.seqbuf),
mutable=true)
end
input.default_alphabet = alphabet
else
copy!(output.seq, input.seqbuf.buffer, 1, length(input.seqbuf))
end
empty!(input.seqbuf)
yield = true;
begin
p+= 1;
cs = 0;
@goto _out

end

end

break;
end

end

end
@label _out
begin

end

end
end)



