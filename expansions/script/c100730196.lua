--高速决斗技能-英雄一闪！！
Duel.LoadScript("speed_duel_common.lua")
function c100730196.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730196.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730196.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetLabel(0)
	e1:SetCountLimit(1,100730196+100)
	e1:SetOperation(c100730196.skillflash)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730196.skillflash(e,tp)
	local count=e:GetLabel()
	count=count+1
	e:SetLabel(count)
	if count==2 then
		Duel.Hint(HINT_CARD,1-tp,100730196)
		local c=Duel.CreateToken(tp,74825788)
		Duel.SendtoHand(c,tp,REASON_RULE)
	elseif count==4 then
		Duel.Hint(HINT_CARD,1-tp,100730196)
		local c=Duel.CreateToken(tp,213326)
		Duel.SendtoHand(c,tp,REASON_RULE)
	elseif count==6 then
		Duel.Hint(HINT_CARD,1-tp,100730196)
		local c=Duel.CreateToken(tp,37318031)
		Duel.SendtoHand(c,tp,REASON_RULE)
	elseif count==8 then
		Duel.Hint(HINT_CARD,1-tp,100730196)
		local c=Duel.CreateToken(tp,63703130)
		Duel.SendtoHand(c,tp,REASON_RULE)
	elseif count==10 then
		Duel.Hint(HINT_CARD,1-tp,100730196)
		local c=Duel.CreateToken(tp,191749)
		Duel.SendtoHand(c,tp,REASON_RULE)
	end
end