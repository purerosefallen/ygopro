--高速决斗技能-卓越的宝玉
Duel.LoadScript("speed_duel_common.lua")
function c100730021.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730021.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730021.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730021)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,0,3,nil,0x1034)
	local c=g:GetFirst()
	while c do
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		c:RegisterEffect(e1)
		c=g:GetNext()
	end
	e:Reset()
end
