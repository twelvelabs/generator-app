package cmd

import (
	"github.com/spf13/cobra"

	"{{ .GoPackage }}/internal/core"
)

func NewRootCmd(app *core.App) *cobra.Command {
	noColor := false
	noPrompt := false
	verbosity := 0

	cmd := &cobra.Command{
		Use:     "{{ .ProjectDir }}",
		Short:   "{{ .ProjectDescription }}",
		Version: app.Meta.Version,
		PersistentPreRunE: func(_ *cobra.Command, _ []string) error {
			if noColor {
				app.Config.Color = false
			}
			if noPrompt {
				app.Config.Prompt = false
			}
			if verbosity == 1 {
				app.Config.LogLevel = "info"
			} else if verbosity >= 2 {
				app.Config.LogLevel = "debug"
			}
			return app.Init()
		},
		RunE: func(_ *cobra.Command, _ []string) error {
			name := app.UI.Cyan("{{ .ProjectDir }}")
			app.UI.Out("Hello from %s 👋 \n", name)
			return nil
		},
		CompletionOptions: cobra.CompletionOptions{
			HiddenDefaultCmd: true,
		},
	}

	flags := cmd.PersistentFlags()
	flags.StringVarP(&app.Config.ConfigPath, "config", "c", app.Config.ConfigPath, "config path")
	flags.CountVarP(&verbosity, "verbose", "v", "enable verbose logging (increase via -vv)")
	flags.BoolVar(&noColor, "no-color", noColor, "do not use color output")
	flags.BoolVar(&noPrompt, "no-prompt", noPrompt, "do not prompt for input")

	cmd.AddCommand(NewManCmd(app))
	cmd.AddCommand(NewVersionCmd(app))

	return cmd
}
