const Post = async (url, data) => {
    try {
        const response = await axios.post(
            `https://${GetParentResourceName()}/${url}`,
            data || {},
            {
                headers: {
                    "Content-Type": "application/json",
                },
            }
        );
        return response.data;
    } catch (error) {
        throw error;
    }
};

const app = Vue.createApp({
    data() {
        return {
            show: false,
            logo: "",
            audios: {
                appendSound: new Audio(
                    "https://r2.fivemanage.com/QbMW9SvJrh8gWirlVt5Ee/gta4.wav"
                ),
                click: new Audio(
                    "https://r2.fivemanage.com/QbMW9SvJrh8gWirlVt5Ee/click.wav"
                ),
                hover: new Audio(
                    "https://r2.fivemanage.com/QbMW9SvJrh8gWirlVt5Ee/hover.wav"
                ),
            },
            buttons: {
                continue: {
                    text: "Continue",
                    icon: "fas fa-play",
                    action: "exit",
                },
                radar: { text: "Map", icon: "fas fa-map", action: "map" },
                settings: {
                    text: "Settings",
                    icon: "fas fa-cog",
                    action: "settings",
                },
                exit: {
                    text: "Exit",
                    icon: "fas fa-power-off",
                    action: "quit",
                },
            },
        };
    },
    methods: {
        getDelayFromKey(key) {
            if (!this.buttons || !key) return 0;
            return Object.keys(this.buttons).indexOf(key) * 0.1;
        },
        async sendAction(action) {
            this.show = false;
            if (action !== "exit") this.sendAction("exit");
            if (action === "quit") {
                window.invokeNative("quit", "you left the game");
            } else {
                try {
                    await Post("SendAction", { action });
                } catch (error) {}
            }
        },
        playSound(audio) {
            audio.currentTime = 0;
            audio.play();
        },
        playHover() {
            this.playSound(this.audios.hover);
        },
        playClick() {
            this.playSound(this.audios.click);
        },
        playOpen() {
            this.playSound(this.audios.appendSound);
        },
        setup({ translatedTbl, serverIcon }) {
            Object.keys(this.buttons).forEach((key) => {
                this.buttons[key].text = translatedTbl[key];
            });
            this.logo = serverIcon;
        },
        openEsc() {
            this.show = true;
            this.playOpen();
        },
        closeEsc() {
            this.show = false;
            this.sendAction("exit");
        },
    },
    mounted() {
        this.show = !navigator.userAgent.includes("CitizenFX");

        this.audios.appendSound.volume = 0.35;
        this.audios.click.volume = 0.75;
        this.audios.hover.volume = 0.75;

        window.addEventListener("message", ({ data }) => {
            if (this[data.action]) this[data.action](data);
        });

        document.onkeydown = ({ key }) => {
            if (key === "Escape") this.closeEsc();
        };
    },
});

app.mount("#app");
