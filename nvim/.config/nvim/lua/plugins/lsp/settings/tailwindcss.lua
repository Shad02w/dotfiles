return {
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    { 'tv\\((([^()]*|\\([^()]*\\))*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
                },
            },
            classFunctions = { 'cva', 'cx', 'tv' },
        },
    },
}
