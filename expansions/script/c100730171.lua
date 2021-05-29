--高速决斗技能-沉默的决斗者
Duel.LoadScript("speed_duel_common.lua")
function c100730171.initial_effect(c)
	if not c100730171.UsedLP then
		c100730171.UsedLP={}
		c100730171.UsedLP[0]=0
		c100730171.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730171.skill1,c100730171.con,aux.Stringid(100730171,1))
	aux.SpeedDuelBeforeDraw(c,c100730171.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730171.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730171.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
end

function c100730171.skill1(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730171,1)) then
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		Duel.Hint(HINT_CARD,1-tp,100730171)
		Duel.SendtoDeck(g:GetFirst(),nil,1,REASON_RULE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
		local sg=Duel.SelectMatchingCard(tp,c100730171.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
		Duel.Summon(tp,sg:GetFirst(),false,nil)
		if aux.DecreasedLP[tp]-c100730171.UsedLP[tp]>=1800 then
			c100730171.UsedLP[tp]=c100730171.UsedLP[tp]+1800
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g1=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,0,1,nil,TYPE_QUICKPLAY)
			Duel.SendtoHand(g1,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g1)
			local g2=Duel.GetMatchingGroup(c100730171.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
			if Duel.GetMZoneCount(1-tp)>0 and g2:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(100730171,0)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local c=g2:Select(tp,1,1,nil)
				Duel.SpecialSummon(c,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
			end
		end
	end
end
function c100730171.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetLabelObject()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730171.LVfilter)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c100730171.efilter)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730171.LV2filter)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCondition(c100730171.atkcon)
	e2:SetValue(c100730171.val)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730171.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c100730171.LV2filter(e,c)
	return c:IsSetCard(0x41) and c:IsRace(RACE_SPELLCASTER+RACE_FIEND) and c:IsFaceup()
end

function c100730171.LVfilter(e,c)
	return c:IsSetCard(0x41) and c:IsRace(RACE_SPELLCASTER+RACE_WARRIOR) and c:IsFaceup()
end
function c100730171.filter(c)
	return c:IsSetCard(0x41) and c:IsLevelBelow(4)
end
function c100730171.efilter(e,te)   
	return not te:GetOwner():IsType(TYPE_SPELL) and not te:GetOwner():IsSetCard(0x41) and te:IsActivated()
end
function c100730171.val(e,c)
	return c:GetLevel()*1000-c:GetTextAttack()-c:GetTextDefense()-1000
end