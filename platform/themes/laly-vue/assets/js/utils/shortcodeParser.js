/**
 * Parses Botble shortcode string into structured blocks
 * Example input: `<p>Text</p> [site-features title="Fast"][/site-features]`
 * Example output: [
 *   { type: 'html', content: '<p>Text</p> ' },
 *   { type: 'shortcode', name: 'site-features', attributes: { title: 'Fast' } }
 * ]
 */
export function parseShortcodes(content) {
    if (!content) return [];
    
    // Botble shortcode regex pattern
    // Match 1: name, Match 2: attributes string, Match 3: inner content
    const regex = /\[([\w-]+)(.*?)\](?:(.*?)\[\/\1\])?/gs;
    
    const blocks = [];
    let lastIndex = 0;
    let match;

    while ((match = regex.exec(content)) !== null) {
        // Add raw HTML before the shortcode
        if (match.index > lastIndex) {
            const htmlChunk = content.substring(lastIndex, match.index);
            if (htmlChunk.trim()) {
                blocks.push({ type: 'html', content: htmlChunk });
            }
        }

        const name = match[1];
        const attributesString = match[2];
        const innerContent = match[3]; // May be undefined if self-closing
        
        // Parse attributes string
        const attributes = parseAttributes(attributesString);

        blocks.push({
            type: 'shortcode',
            name: name,
            attributes: attributes,
            content: innerContent
        });

        lastIndex = regex.lastIndex;
    }

    // Add remaining HTML after the last shortcode
    if (lastIndex < content.length) {
        const htmlChunk = content.substring(lastIndex);
        if (htmlChunk.trim()) {
            blocks.push({ type: 'html', content: htmlChunk });
        }
    }

    return blocks;
}

function parseAttributes(attrString) {
    const attributes = {};
    if (!attrString || !attrString.trim()) return attributes;

    // Matches key="value" or key='value' or key=value
    const attrRegex = /(\w+)\s*=\s*("([^"\\]*(?:\\.[^"\\]*)*)"|'([^'\\]*(?:\\.[^'\\]*)*)'|([^\s'"]+))/g;
    let match;

    while ((match = attrRegex.exec(attrString)) !== null) {
        const key = match[1].toLowerCase();
        let value = '';
        if (match[3] !== undefined) {
            value = match[3]; // Double quotes
        } else if (match[4] !== undefined) {
            value = match[4]; // Single quotes
        } else if (match[5] !== undefined) {
            value = match[5]; // Unquoted
        }
        
        // Replace escaped quotes if necessary (Botble handles \" sometimes)
        value = value.replace(/\\"/g, '"').replace(/\\'/g, "'");
        
        attributes[key] = value;
    }

    return attributes;
}
