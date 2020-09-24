use std::process::Command;
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
struct Cli {
    #[structopt(subcommand)]
    cmd: Cmd,

    /// Silence Ruby deprecation warnings
    #[structopt(short = "q", long = "quiet")]
    silence_ruby_warnings: bool,
}

#[derive(Debug, StructOpt)]
#[structopt(
    about = "Interact with the local Docker development environment",
    rename_all = "kebab-case"
)]
enum Cmd {
    /// Tears down any exiting images, containers, networks, etc. and
    /// sets everything up from scratch. This also seeds the
    /// development database. You can create a default admin account
    /// by setting `SYSTEM_EMAIL` and `SYSTEM_PASSWORD` values in
    /// `<project-root>/.env.local`
    Bootstrap,

    /// Destroys all docker resources for the application and
    /// services.
    Clean,

    /// Starts a Rails console inside an application container and
    /// establishes a TTY connection to it from the user's terminal
    Console,

    /// Starts a shell inside the application container and
    /// establishes a TTY connection to it from the user's
    /// terminal. Useful for things like generating migrations,
    /// exploring the container file system, etc.
    Shell,

    /// Stops the web application container and its supporting
    /// services - RDBMS, mailcatcher, webpacker, etc.
    Stop,

    /// Runs the tests inside the context of the app container.
    Test,

    /// Seeds <environment> database.
    Seed {
        #[structopt(short = "e", long, default_value = "development")]
        environment: String,
    },
}

fn execute_command(command: &mut Command, cli: &Cli) -> () {
    let command = if cli.silence_ruby_warnings == true {
        command.env("RUBYOPT", "-W:no-deprecated")
    } else {
        command
    };

    let res = command.status();

    match res {
        Err(why) => panic!("{:?}", why),
        Ok(_output) => {}
    };
}

fn docker() -> Command {
    let mut command = Command::new("docker-compose");
    command.args(&["-f", "docker/development/docker-compose.yml"]);

    command
}

fn reset_db(environment: &str, cli: &Cli) -> () {
    let mut command = docker();
    command.args(&[
        "run",
        "--rm",
        "-e",
        &format!("RAILS_ENV={}", environment),
        "app",
        "bin/rails",
        "db:reset",
    ]);

    execute_command(&mut command, cli);
}

fn seed(environment: &str, cli: &Cli) -> () {
    let mut command = docker();
    command.args(&[
        "run",
        "--rm",
        "-e",
        &format!("RAILS_ENV={}", environment),
        "app",
        "bin/rails",
        "db:seed",
    ]);

    execute_command(&mut command, cli);
}

fn bootstrap(cli: &Cli) -> () {
    clean(&cli);
    reset_db("development", &cli);
    seed("test", &cli);
}

fn clean(cli: &Cli) -> () {
    let mut command = docker();
    command.args(&["down", "--rmi=all", "--volumes", "--remove-orphans"]);

    execute_command(&mut command, cli);
}

fn console(cli: &Cli) -> () {
    let mut command = docker();
    command.args(&["run", "--rm", "app", "bin/rails", "console"]);

    execute_command(&mut command, cli);
}

fn shell(cli: &Cli) -> () {
    let mut command = docker();
    command.args(&["run", "--rm", "app", "/bin/sh"]);

    execute_command(&mut command, cli);
}

fn stop(cli: &Cli) -> () {
    let mut command = docker();
    command.arg("down");

    execute_command(&mut command, cli);
}

fn test(cli: &Cli) -> () {
    let mut command = docker();
    command.args(&["run", "--rm", "app", "bin/test"]);

    execute_command(&mut command, cli);
}

fn main() {
    let cli = Cli::from_args();

    match cli.cmd {
        Cmd::Bootstrap => bootstrap(&cli),
        Cmd::Clean => clean(&cli),
        Cmd::Console => console(&cli),
        Cmd::Shell => shell(&cli),
        Cmd::Stop => stop(&cli),
        Cmd::Test => test(&cli),
        _ => println!("unknown command: {:?}", &cli.cmd),
    };
}
