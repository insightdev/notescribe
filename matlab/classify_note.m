% Rule-based classifier for note classification based on a frequency.
function [note_str] = classify_note(freq, tol)

% tol is the variance in the note that is allowed, in percent.
% If the frequency  is outside the tolerated value, the note changes to
% the next frequency band.

% Very simple rule-based classifier.
% Frequency bands are universal for guitars.

if noterange(0,80,tol)<freq && freq<noterange(1,80,tol)
	note_str = "E2";

elseif noterange(0,87.307,tol)<freq && freq<noterange(1,87.307,tol)
	note_str = "F2";

elseif noterange(0,92.499,tol)<freq && freq<noterange(1,92.499,tol)
	note_str = "F#2";

elseif noterange(0,97.999,tol)<freq && freq<noterange(1,97.999,tol)
	note_str = "G2";

elseif noterange(0,103.826,tol)<freq && freq<noterange(1,103.826,tol)
	note_str = "G#2";

elseif noterange(0,110,tol)<freq && freq<noterange(1,110,tol)
	note_str = "A2";

elseif noterange(0,116.541,tol)<freq && freq<noterange(1,116.541,tol)
	note_str = "A#2";

elseif noterange(0,123.471,tol)<freq && freq<noterange(1,123.471,tol)
	note_str = "B2";

elseif noterange(0,130.813,tol)<freq && freq<noterange(1,130.813,tol)
	note_str = "C3";

elseif noterange(0,138.591,tol)<freq && freq<noterange(1,138.591,tol)
	note_str = "C#3";

elseif noterange(0,146.832,tol)<freq && freq<noterange(1,146.832,tol)
	note_str = "D3";

elseif noterange(0,155.563,tol)<freq && freq<noterange(1,155.563,tol)
	note_str = "D#3";

elseif noterange(0,164.814,tol)<freq && freq<noterange(1,164.814,tol)
	note_str = "E3";

elseif noterange(0,174.614,tol)<freq && freq<noterange(1,174.614,tol)
	note_str = "F3";

elseif noterange(0,184.997,tol)<freq && freq<noterange(1,184.997,tol)
	note_str = "F#3";

elseif noterange(0,195.998,tol)<freq && freq<noterange(1,195.998,tol)
	note_str = "G3";

elseif noterange(0,207.652,tol)<freq && freq<noterange(1,207.652,tol)
	note_str = "G#3";

elseif noterange(0,220,tol)<freq && freq<noterange(1,220,tol)
	note_str = "A3";

elseif noterange(0,233.082,tol)<freq && freq<noterange(1,233.082,tol)
	note_str = "A#3";

elseif noterange(0,246.942,tol)<freq && freq<noterange(1,246.942,tol)
	note_str = "B3";

elseif noterange(0,261.626,tol)<freq && freq<noterange(1,261.626,tol)
	note_str = "C4";
	
elseif noterange(0,277.183,tol)<freq && freq<noterange(1,277.183,tol)
	note_str = "C#4";

elseif noterange(0,293.665,tol)<freq && freq<noterange(1,293.665,tol)
	note_str = "D4";

elseif noterange(0,311.127,tol)<freq && freq<noterange(1,311.127,tol)
	note_str = "D#4";

elseif noterange(0,329.628,tol)<freq && freq<noterange(1,329.628,tol)
	note_str = "E4";

elseif noterange(0,349.228,tol)<freq && freq<noterange(1,349.228,tol)
	note_str = "F4";

elseif noterange(0,369.994,tol)<freq && freq<noterange(1,369.994,tol)
	note_str = "F#4";

elseif noterange(0,391.995,tol)<freq && freq<noterange(1,391.995,tol)
	note_str = "G4";

elseif noterange(0,415.305,tol)<freq && freq<noterange(1,415.305,tol)
	note_str = "G#4";

elseif noterange(0,440,tol)<freq && freq<noterange(1,440,tol)
	note_str = "A4";

elseif noterange(0,466.164,tol)<freq && freq<noterange(1,466.164,tol)
	note_str = "A#4";

elseif noterange(0,493.883,tol)<freq && freq<noterange(1,493.883,tol)
	note_str = "B4";

elseif noterange(0,523.251,tol)<freq && freq<noterange(1,523.251,tol)
	note_str = "C5";

elseif noterange(0,554.365,tol)<freq && freq<noterange(1,554.365,tol)
	note_str = "C#5";

elseif noterange(0,587.33,tol)<freq && freq<noterange(1,587.33,tol)
	note_str = "D5";
else
	note_str = "";
end