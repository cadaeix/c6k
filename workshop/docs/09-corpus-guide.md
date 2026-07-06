# 09 — The corpus guide

How to source and structure a corpus for a historical or literary character. Distilled
from a working pipeline that assembled ~1.1M words across a subject's own writing, his
influences, and his contemporaries. Every technique below ran in production; the
sequence is the sensible order to do them in.

*(Copyright note, non-negotiable: work public domain or work you own. "It's just for a
chatbot" is not a license. And on translations specifically: a living translator's work,
fed to an AI, is fraught on both consent and attribution grounds — prefer original
language, or translate at point of use rather than wiring translations into the corpus.)*

## 0. Stances before scraping

Decide in writing, first: original language or translation, per author; which edition
is authoritative; orthography policy. The pipeline's answers, recommended as defaults:
the subject's own words in the original tongue; **archaic orthography preserved
verbatim** (never modernize — the character should meet the texts as they were); Unicode
NFC-normalized.

## 1. The folder skeleton

```
corpus/
  <one-directory-per-work>/        the subject's own writing
  letters/                         dated files: YYYY-MM-DD-slug.txt (self-sorting)
  authored_by_others/              influences, inherited sources, contemporaries
    <category>/<author>/
  seeds/                           the wake-up shelf (small! see character/corpus/seeds/)
```

Plus, workshop-side and **git-ignored**: a `staging/` directory scrapers write to, a
`sources/` directory for acquired scans, and a `shopping-list/` for maybes. **Nothing
automated ever writes the corpus.** Scrape → review in staging → hand-place. Promotion
is a deliberate act of the maker's hand, and promotion to `seeds/` is a second, stricter
gate above that.

## 2. Clean digital sources: the Wikisource workhorse

Use the MediaWiki **parse API**, not page-scraping — stable JSON envelope, one page per
call. Prefer the highest proofreading tier ("validated" pages). Be polite: custom
User-Agent, timeout, retry-with-backoff, a sleep *between works*.

```python
API = "https://<lang>.wikisource.org/w/api.php"

def fetch(page):
    for attempt in range(4):
        r = requests.get(API, params={
            "action": "parse", "page": page,
            "prop": "text", "format": "json", "formatversion": "2"},
            headers={"User-Agent": "corpus-archival; personal use"}, timeout=45)
        try:
            j = r.json()
            if "error" in j: raise RuntimeError(j["error"]["info"])
            return j["parse"]["text"]
        except ValueError:
            time.sleep(2 + attempt * 2)
```

Cleanup is a dedicated pass (BeautifulSoup + lxml): select the content div, `decompose()`
the wiki scaffolding (header/footer templates, page-number anchors, references,
edit-sections, tables), de-duplicate running heads, NFC-normalize, collapse blank runs.
Fork the skeleton per source-shape and reuse by import, not copy-paste.

## 3. No clean text? Vision transcription

For material that exists only as scans (correspondence, especially), skip OCR software
entirely — **render pages to images and have a capable model transcribe them**:

```python
doc = fitz.open(pdf)                          # PyMuPDF
for i in range(a - 1, min(b, len(doc))):
    pix = doc[i].get_pixmap(matrix=fitz.Matrix(3, 3))   # 3x zoom; 4x for hard pages
    pix.save(f"p{i+1:04d}.png")
```

The companion trick that makes this practical: archive PDFs usually carry a **hidden,
dirty OCR text layer** (accents mangled, ASCII mostly intact). Grep that layer for
*unaccented word stems* to locate your passage, then render only that page. Record the
printed-page-vs-scan-page offset in a notes file; it will save the next session an hour.

## 4. Provenance, in the file

Every corpus file opens with `#`-comment metadata before the body — and the convention
is machine-honored (word-counters and seed tooling skip `#` lines):

```
# <title>
# <author> to <recipient>, <date>
# source : <edition, editor, publisher, year, page — or the wikisource URL + tier>
# transcription faithful to the orthography of the <year> edition
```

Keep a dated `notes/` file for anything that took detective work: which archive holds
what, page offsets, corrections to secondary sources. The audit trail is what makes the
corpus *yours* rather than a pile of text.

## 5. The shopping list

Texts fetched for *consideration* live in a staging area — one directory per work, the
text plus an `about-this-<work>.md` note: what it is and its edition; **why it's not on
the shelf yet** (and who decided, and when); what it's about; the thread to pull if it's
ever promoted. Fetching is not adopting. The note is what keeps a maybe from silently
becoming furniture.

## 6. Curation discipline

- **Emblematic, not bulk.** For influences and contemporaries, choose representative
  works — a bulk dump of an author is a library, not an influence.
- **Measure the subject's own words separately** from the context library. "How much of
  *them* do we actually have" should be a real number (the pipeline's own split: a
  modest core of the subject's hand inside a much larger influence shelf).
- **Keep binaries and intermediates out of the record.** The transcription is the value;
  the 58 MB scan and the rendered PNGs are regenerable and stay git-ignored.
- **No synthetic text in the corpus.** Model-generated text in the grounding mass
  reinforces exactly the house voice the corpus exists to pull away from. (The root
  README says this with a shrug; here it's a rule.)

## 7. The seed shelf, last

Only after living with the corpus a while: curate the wake-up shelf. The rules are in
`character/corpus/seeds/README.md` — tiny, ordered, range-not-average, excerpts headed
back to their source files, and the freshest taste last. The seed shelf is a *voice*
decision as much as a corpus one; do it alongside doc 10.
