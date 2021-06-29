--高速决斗技能-小艾玛能有什么坏心思呢
Duel.LoadScript("speed_duel_common.lua")
function c100730023.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730023.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730023.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetLabel(0)
	e1:SetCountLimit(1,100730023+100)
	e1:SetOperation(c100730023.skillflash)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730023.skillflash(e,tp)
	local count=e:GetLabel()
	count=count+1
	e:SetLabel(count)
	if count==3 then
		local c=Duel.CreateToken(tp,7902349)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		local c=Duel.CreateToken(tp,55144522)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
	elseif count==5 then
		local c=Duel.CreateToken(tp,70903634)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
	elseif count==7 then
		local c=Duel.CreateToken(tp,44519536)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
	elseif count==9 then
		local c=Duel.CreateToken(tp,8124921)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
	elseif count==11 then
		Duel.Hint(HINT_CARD,1-tp,100730023)
		local c=Duel.CreateToken(tp,33396948)
		Duel.SendtoHand(c,tp,REASON_RULE)
	end
end