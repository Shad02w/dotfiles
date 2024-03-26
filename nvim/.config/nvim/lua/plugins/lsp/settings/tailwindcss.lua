return {
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    { 'tv\\((([^()]*|\\([^()]*\\))*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
                },
            },
        },
    },
}
