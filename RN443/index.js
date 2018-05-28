import React from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View
} from 'react-native';

class RNHighScores extends React.Component {
    render() {
        var contents = this.props["scores"].map(
            score => <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
        );
        return (
            <View style={styles.container}>
                <Text style={styles.highScoresTitle}>efwf
                    2048 High Scores! 哈哈哈哈哈哈哈哈--qwdwf-------------我
                </Text>
                <Text style={styles.scores}>
                    {contents}
                </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#FFFFFF',
    },
    highScoresTitle: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    scores: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});

// 整体js模块的名称
AppRegistry.registerComponent('MyReactNativeApp', () => RNHighScores);